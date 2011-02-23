class CreateEstimateSignatures < ActiveRecord::Migration
  def self.up
    create_table :estimate_signatures do |t|
      t.references :user
      t.references :estimate
      t.timestamps
    end
  end

  def self.down
    drop_table :estimate_signatures
  end
end
