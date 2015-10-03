class AddAttachmentPhotos < ActiveRecord::Migration
  def up
    add_attachment :photos, :attachment
  end

  def down
    remove_attachment :photos, :attachment
  end
end
