class AddRoleToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :role, index: true
    end

    add_foreign_key :users, :roles
  end
end
