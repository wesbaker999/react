class CreateScenarios < ActiveRecord::Migration
  def self.up
    create_table :scenarios do |t|
      t.references :story
      t.string :title
      t.text :description
      t.integer :story_scenario_id
      t.timestamps
    end
  end

  def self.down
    drop_table :scenarios
  end
end
