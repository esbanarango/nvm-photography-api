class AddReferenceLocationToPhotos < ActiveRecord::Migration
  def change
  	add_reference :photos, :location, index: true
    add_foreign_key :photos, :locations
  end
end
