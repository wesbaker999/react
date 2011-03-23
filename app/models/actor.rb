class Actor < ActiveRecord::Base
  belongs_to :project
  has_many :features

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:project_id]

  scope :alphabetical, :order => :name
end
