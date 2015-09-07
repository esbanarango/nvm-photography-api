class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :camara, index: true, foreign_key: true
      t.text :description
      t.string :aperture
      t.string :exposure
      t.integer :iso
      t.string :shutter_speed
      t.string :color_space
      t.integer :focal_length
      t.datetime :took_at
      t.text :settings

      t.timestamps null: false
    end
  end
end
