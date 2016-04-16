class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.string :image
      t.references :author, index: true, references: :users

      t.timestamps null: false
    end
    add_foreign_key :articles, :users, column: :author_id
  end
end
