class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.references :article, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
