class Invitation < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :email, :project
  validates_uniqueness_of :email, :scope => [:project_id]

  before_create :set_uuid

  def to_param
    self.uuid.to_s
  end

  def accept!(user)
    self.project.memberships.create(:user => user, :admin => self.admin?, :developer => self.developer?, :client => self.client?)
    destroy
  end

  protected

  def set_uuid
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
end
