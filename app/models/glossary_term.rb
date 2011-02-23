class GlossaryTerm < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :name, :definition, :project

  scope :alphabetical, :order => :name
end
