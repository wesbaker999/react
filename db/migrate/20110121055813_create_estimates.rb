class CreateEstimates < ActiveRecord::Migration
  def self.up
    create_table :estimates do |t|
      t.integer :developer_signature_id
      t.integer :client_signature_id
      t.references :project
      t.timestamps
    end
  end

  def self.down
    drop_table :estimates
  end
end
