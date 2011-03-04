class Project < ActiveRecord::Base
  has_many :actors
  has_many :memberships
  has_many :features
  has_many :glossary_terms
  has_many :invitations
  has_many :estimates

  validates_presence_of :name

  scope :alphabetical, :order => :name
  scope :except, lambda {|p| {:conditions => ["projects.id != ?", p.id]}}

  accepts_nested_attributes_for :memberships

  after_create :create_actor

  def next_project_feature_id
    Project.increment_counter(:project_feature_id_counter, self.id)
    self.reload
    self.project_feature_id_counter
  end

  def generate_api_key!
    self.api_key = UUIDTools::UUID.random_create.hexdigest
    save
  end

  protected

  def create_actor
    self.actors.create(:name => "User", :description => "<<Replace this with a real description of a User within your system>>")
  end
end
