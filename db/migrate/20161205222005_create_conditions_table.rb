class CreateConditionsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :conditions do |t|
      t.date  :measurement_date
      t.float :max_temperature_f
      t.float :mean_temperature_f
      t.float :min_temperature_f
      t.float :humidity_percent
      t.float :visibility_miles
      t.float :mean_wind_speed_mph
      t.float :precipitation_inches

      t.timestamps null: false
    end
  end
end
