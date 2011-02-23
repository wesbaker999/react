class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_presence_of :project, :user

  scope :for_user, lambda {|user| {:conditions => {:user_id => user.id}}}
end
