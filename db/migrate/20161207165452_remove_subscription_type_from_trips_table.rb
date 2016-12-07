class RemoveSubscriptionTypeFromTripsTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :trips, :subscription_type, :integer
    add_column    :trips, :subscription_id, :integer
  end
end
