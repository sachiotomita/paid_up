# This migration comes from paid_up (originally 20150407110102)
class CreatePaidUpSubscriptionsTable < ActiveRecord::Migration
  def change
    create_table :paid_up_subscriptions do |t|
      t.references :plan
      t.integer   :subscriber_id
      t.string    :subscriber_type
      t.datetime :charged_at

      t.timestamps
    end
    add_index :paid_up_subscriptions, :plan_id
    add_index :paid_up_subscriptions, [:subscriber_type, :subscriber_id], name: 'subscriber'
  end
end