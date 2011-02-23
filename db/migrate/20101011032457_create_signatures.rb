class CreateSignatures < ActiveRecord::Migration
  def self.up
    create_table :signatures do |t|
      t.references :story
      t.references :user
      t.timestamps
    end

    add_column :stories, :developer_signature_id, :integer
    add_column :stories, :client_signature_id, :integer

    add_column :story_versions, :developer_signature_id, :integer
    add_column :story_versions, :client_signature_id, :integer
  end

  def self.down
    drop_table :signatures

    remove_column :stories, :developer_signature_id
    remove_column :stories, :client_signature_id

    remove_column :story_versions, :developer_signature_id
    remove_column :story_versions, :client_signature_id
  end
end
