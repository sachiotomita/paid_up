module PaidUp
  class InstallGenerator < Rails::Generators::NamedBase
    argument :user_model_name, :type => :string, :default => "User"
    source_root File.expand_path("../templates", __FILE__)
    require File.expand_path('../../utils', __FILE__)
    include Generators::Utils
    include Rails::Generators::Migration

    def hello
      output "PaidUp Installer will now install itself", :magenta
    end

    # all public methods in here will be run in order

    def install_devise
      output "To start with, Devise is used to authenticate #{user_model_name.pluralize}. No need to install it separately, I'll do that now.", :magenta
      generate("devise:install")
      generate("devise #{user_model_name}")
    end

    def add_initializer
      output "Next, you'll need an initializer.  This is where you put your configuration options.", :magenta
      template "initializer.rb.erb", "config/initializers/paid_up.rb", assigns: { user_model: ('::' + user_model_name).constantize.new }
    end

    def add_migrations
      output "Next come migrations.", :magenta
      rake 'paid_up:install:migrations'
      unless self.class.migration_exists?('db/migrate', 'add_customer_stripe_id.rb')
        generate("migration AddStripeIdColumnTo#{user_model_name} stripe_id:string:index")
      end
    end

    def add_to_model
      output "Adding PaidUp to your #{user_model_name} model", :magenta
      gsub_file "app/models/#{user_model_name.downcase}.rb", /^\n  subscriber$/, ''
      inject_into_file "app/models/#{user_model_name.downcase}.rb", "\n  subscriber", after: "class #{user_model_name} < ActiveRecord::Base"
    end

    def add_route
      output "Adding PaidUp to your routes.rb file", :magenta
      gsub_file "config/routes.rb", /mount PaidUp::Engine => '\/.*', :as => 'paid_up'/, ''
      route("mount PaidUp::Engine => '/', :as => 'paid_up'")
    end

    def self.next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end
  end
end