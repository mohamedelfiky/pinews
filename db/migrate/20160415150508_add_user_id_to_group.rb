class AddUserIdToGroup < ActiveRecord::Migration
  def change
    change_table :groups do |t|
      t.references :user, index: true
    end

    add_foreign_key :groups, :users
  end
end
