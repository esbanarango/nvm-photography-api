class CreateCamaras < ActiveRecord::Migration
  def change
    create_table :camaras do |t|
      t.string :model

      t.timestamps null: false
    end
  end
end
