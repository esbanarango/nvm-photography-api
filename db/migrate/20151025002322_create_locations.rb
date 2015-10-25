class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string 	:country
      t.string 	:country_code
      t.string 	:city
      t.integer :photos_count, default: 0, null: false

      t.timestamps null: false
    end
  end
end
