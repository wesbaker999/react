class Story < ActiveRecord::Base
  class << self
    include HTMLDiff
  end
  
  acts_as_versioned

  belongs_to :project
  belongs_to :actor

  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"

  has_many :signatures
  has_many :comments
  has_many :scenarios

  belongs_to :developer_signature, :class_name => "Signature"
  belongs_to :client_signature, :class_name => "Signature"

  validates_presence_of :project, :title, :description, :actor

  before_create :set_project_story_id

  scope :by_updated_at, :order => "updated_at DESC"
  scope :by_updated_at_asc, :order => "updated_at ASC"
  scope :by_id, :order => "id"
  scope :by_id_desc, :order => "id DESC"
  scope :unsigned_for, lambda { |membership|
    if membership.developer? or membership.client?
      hash = {}
      hash[:developer_signature_id] = nil if membership.developer?
      hash[:client_signature_id] = nil if membership.client?
      {:conditions => hash}
    else
      {:conditions => "1=0"}
    end
  }
  scope :signed, {:conditions => "developer_signature_id IS NOT NULL AND client_signature_id IS NOT NULL"}
  scope :search, lambda {|q| {:conditions => ["stories.title LIKE ? OR stories.description LIKE ?", "%#{q}%", "%#{q}%"]}}

  def to_param
    self.project_story_id.to_s
  end

  def needs_signatures?
    self.client_signature_id.blank? or self.developer_signature_id.blank?
  end

  def client_sign!(signee)
    self.client_signature = self.signatures.create(:user => signee)
    save_without_revision!
  end

  def developer_sign!(signee)
    self.developer_signature = self.signatures.create(:user => signee)
    save_without_revision!
  end

  def next_story_scenario_id
    Story.increment_counter(:story_scenario_id_counter, self.id)
    self.reload
    self.story_scenario_id_counter
  end

  def title_with_number
    "##{self.project_story_id}: #{self.title}"
  end

  protected

  def set_project_story_id
    self.project_story_id = self.project.next_project_story_id
  end

end
