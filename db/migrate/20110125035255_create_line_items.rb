class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.references :estimate
      t.string :description
      t.integer :min_hours
      t.integer :max_hours
      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
