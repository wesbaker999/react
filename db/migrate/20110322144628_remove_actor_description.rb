class RemoveActorDescription < ActiveRecord::Migration
  def self.up
    remove_column :actors, :description
  end

  def self.down
    add_column :actors, :description, :text
  end
end
