class DropScenarios < ActiveRecord::Migration
  def self.up
    drop_table :scenarios
  end

  def self.down
    create_table :scenarios
  end
end
