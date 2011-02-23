class AddNameToEstimates < ActiveRecord::Migration
  def self.up
    add_column :estimates, :name, :string
  end

  def self.down
    remove_column :estimates, :name
  end
end
