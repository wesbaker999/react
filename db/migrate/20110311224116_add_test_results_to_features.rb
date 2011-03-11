class AddTestResultsToFeatures < ActiveRecord::Migration
  def self.up
    add_column :features, :num_tests, :integer
    add_column :features, :num_failures, :integer
    add_column :feature_versions, :num_tests, :integer
    add_column :feature_versions, :num_failures, :integer
  end

  def self.down
    remove_column :features, :num_tests
    remove_column :features, :num_failures
    remove_column :feature_versions, :num_tests
    remove_column :feature_versions, :num_failures
  end
end
