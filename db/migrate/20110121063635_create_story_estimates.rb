class CreateStoryEstimates < ActiveRecord::Migration
  def self.up
    create_table :story_estimates do |t|
      t.references :estimate
      t.references :story
      t.integer :min_hours
      t.integer :max_hours
      t.timestamps
    end
  end

  def self.down
    drop_table :story_estimates
  end
end
