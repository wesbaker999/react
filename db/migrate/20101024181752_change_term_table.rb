class ChangeTermTable < ActiveRecord::Migration
  def self.up
    rename_table :terms, :glossary_terms
  end

  def self.down
    rename_table :glossary_terms, :terms

  end
end
