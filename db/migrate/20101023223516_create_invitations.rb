class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.references  :project
      t.string      :uuid
      t.string      :email
      t.boolean     :admin,      :default => false
      t.boolean     :developer,  :default => false
      t.boolean     :client,     :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
