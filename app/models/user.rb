class User < ActiveRecord::Base
  acts_as_authentic

  has_many :memberships
  has_many :projects, :through => :memberships

  validates_presence_of :name, :email
end
