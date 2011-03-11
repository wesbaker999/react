class AddTestReportToFeatures < ActiveRecord::Migration
  def self.up
    add_column :features, :test_report, :text
    add_column :feature_versions, :test_report, :text
  end

  def self.down
    remove_column :features, :test_report
    remove_column :feature_versions, :test_report
  end
end
