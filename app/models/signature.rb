class Signature < ActiveRecord::Base
  belongs_to :feature
  belongs_to :user

  validates_presence_of :feature, :user
end
