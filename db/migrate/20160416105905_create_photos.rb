class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.references :article, index: true, foreign_key: true
      t.string :image

      t.timestamps null: false
    end
  end
end
