class AddNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    remove_column :users, :login
  end

  def self.down
    remove_column :users, :name
    add_column :users, :login, :string
  end
end
