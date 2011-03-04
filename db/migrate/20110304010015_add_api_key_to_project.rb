class AddApiKeyToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :api_key, :string, :default => nil
  end

  def self.down
    remove_column :projects, :api_key
  end
end
