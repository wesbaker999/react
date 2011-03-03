class RenameStoriesToFeatures < ActiveRecord::Migration
  def self.up
    rename_table "stories", "features"
    rename_table "story_versions", "feature_versions"
    rename_table "story_estimates", "feature_estimates"
    rename_column "comments", "story_id", "feature_id"
    rename_column "signatures", "story_id", "feature_id"
    rename_column "feature_estimates", "story_id", "feature_id"
    rename_column "feature_versions", "story_id", "feature_id"
    rename_column "projects", "project_story_id_counter", "project_feature_id_counter"
    rename_column "features", "project_story_id", "project_feature_id"
    remove_column "features", "story_scenario_id_counter"
    remove_index "feature_versions", :name => "index_story_versions_on_story_id"
    add_index "feature_versions", ["feature_id"], :name => "index_feature_versions_on_feature_id"
  end

  def self.down
    rename_column "comments" , "feature_id", "story_id"
    rename_column "signatures" , "feature_id", "story_id"
    rename_column "feature_estimates", "feature_id", "story_id"
    rename_column "feature_versions", "feature_id", "story_id"
    rename_column "projects", "project_feature_id_counter", "project_story_id_counter"
    rename_column "features", "project_feature_id", "project_story_id"
    remove_index "feature_versions", :name => "index_feature_versions_on_feature_id"
    add_index "feature_versions", ["story_id"], :name => "index_story_versions_on_story_id"
    rename_table "features", "stories"
    rename_table "feature_versions", "story_versions"
    rename_table "feature_estimates", "story_estimates" 
  end
end
