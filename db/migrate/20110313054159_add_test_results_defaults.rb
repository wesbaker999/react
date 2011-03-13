class AddTestResultsDefaults < ActiveRecord::Migration
  def self.up
    change_column_default :features, :num_tests, 0
    change_column_default :features, :num_failures, 0
    change_column_default :feature_versions, :num_tests, 0
    change_column_default :feature_versions, :num_failures, 0
  end

  def self.down
  end
end
