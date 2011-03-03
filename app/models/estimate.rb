class Estimate < ActiveRecord::Base
  has_many :feature_estimates
  has_many :features, :through => :feature_estimates
  has_many :estimate_signatures
  has_many :line_items
  belongs_to :project
  belongs_to :developer_signature, :class_name => "EstimateSignature"
  belongs_to :client_signature, :class_name => "EstimateSignature"

  accepts_nested_attributes_for :feature_estimates
  accepts_nested_attributes_for :line_items

  before_update :clear_signatures

  scope :by_updated_at, :order => "updated_at DESC"

  def needs_signatures?
    self.client_signature_id.blank? || self.developer_signature_id.blank?
  end

  def client_sign!(signee)
    self.client_signature = self.estimate_signatures.create(:user => signee)
    save
  end

  def developer_sign!(signee)
    self.developer_signature = self.estimate_signatures.create(:user => signee)
    save
  end

  def min_hours_total
    self.feature_estimates.min_total.first.total.to_i + self.line_items.min_total.first.total.to_i
  end

  def max_hours_total
    self.feature_estimates.max_total.first.total.to_i + self.line_items.max_total.first.total.to_i
  end

  protected

  def clear_signatures
    unless self.client_signature_id_changed? || self.developer_signature_id_changed?
      self.client_signature_id = nil
      self.developer_signature_id = nil
    end
  end
end