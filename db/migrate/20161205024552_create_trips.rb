class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.integer  :duration_in_seconds
      t.datetime :start_date
      t.datetime :end_date
      t.integer  :start_station
      t.integer  :end_station
      t.integer  :bike_id
      t.integer  :subscription_type
      t.integer  :zipcode_id

      t.timestamps null: false
    end
  end
end
