class AddUpdatedBy < ActiveRecord::Migration
  def self.up
    add_column :stories, :updated_by_id, :integer
    add_column :story_versions, :updated_by_id, :integer
  end

  def self.down
    remove_column :stories, :updated_by_id
    remove_column :story_versions, :updated_by_id
  end
end
