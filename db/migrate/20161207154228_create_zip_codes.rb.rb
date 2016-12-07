class CreateZipCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :zipcodes do |t|
      t.integer :zipcode

      t.timestamps null: false
    end
  end
end
