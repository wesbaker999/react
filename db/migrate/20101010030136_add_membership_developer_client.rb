class AddMembershipDeveloperClient < ActiveRecord::Migration
  def self.up
    add_column :memberships, :developer, :boolean, :default => false
    add_column :memberships, :client, :boolean, :default => false
  end

  def self.down
    remove_column :memberships, :developer
    remove_column :memberships, :client
  end
end
