module SubscriptionFeatures
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    require File.expand_path('../../utils', __FILE__)
    include Generators::Utils
    include Rails::Generators::Migration

    def hello
      output "SubscriptionFeatures Installer will now install itself", :magenta
    end

    # all public methods in here will be run in order

    def add_initializer
      output "To start with, you'll need an initializer.  This is where you put your configuration options.", :magenta
      template "initializer.rb", "config/initializers/SubscriptionFeatures.rb"
    end

    def add_migrations
      unless ActiveRecord::Base.connection.table_exists? 'features'
        migration_template 'migrate/create_features_table.rb', 'db/migrate/create_features_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'features_plans'
        migration_template 'migrate/create_features_plans_table.rb', 'db/migrate/create_features_plans_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'plans'
        migration_template 'migrate/create_plans_table.rb', 'db/migrate/create_plans_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'subscriptions'
        migration_template 'migrate/create_subscriptions_table.rb', 'db/migrate/create_subscriptions_table.rb' rescue output $!.message
      end
    end

    def add_route
      output "Adding SubscriptionFeatures to your routes.rb file", :magenta
      gsub_file "config/routes.rb", /mount SubscriptionFeatures::Engine => '\/.*', :as => 'SubscriptionFeatures'/, ''
      route("mount SubscriptionFeatures::Engine => '/subscription_features', :as => 'SubscriptionFeatures'")
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