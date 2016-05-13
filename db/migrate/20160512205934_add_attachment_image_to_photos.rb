class AddAttachmentImageToPhotos < ActiveRecord::Migration
  def self.up
    remove_column :photos, :image
    change_table :photos do |t|
      t.attachment :image
    end
  end

  def self.down
    add_column :photos, :image, :string
    remove_attachment :photos, :image
  end
end
