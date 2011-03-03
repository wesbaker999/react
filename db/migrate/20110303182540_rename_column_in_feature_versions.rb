class RenameColumnInFeatureVersions < ActiveRecord::Migration
  def self.up
    rename_column "feature_versions", "project_story_id", "project_feature_id"
    remove_column "feature_versions", "story_scenario_id_counter"
  end

  def self.down

  end
end
