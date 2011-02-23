class AddStoryIdCounter < ActiveRecord::Migration
  def self.up
    add_column :projects, :project_story_id_counter, :integer, :default => 0
    add_column :stories, :project_story_id, :integer
  end

  def self.down
    remove_column :projects, :project_story_id_counter
    remove_column :stories, :project_story_id
  end
end
