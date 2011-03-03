class Comment < ActiveRecord::Base

  belongs_to :feature
  belongs_to :user

  validates_presence_of :body

  scope :latest, :order => "created_at DESC"
end