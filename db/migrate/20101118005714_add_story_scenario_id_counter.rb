class AddStoryScenarioIdCounter < ActiveRecord::Migration
  def self.up
    add_column :stories, :story_scenario_id_counter, :integer, :default => 0
    add_column :story_versions, :story_scenario_id_counter, :integer, :default => 0
  end

  def self.down
    remove_column :stories, :story_scenario_id_counter
    remove_column :story_versions, :story_scenario_id_counter
  end
end
