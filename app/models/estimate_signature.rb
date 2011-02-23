class EstimateSignature < ActiveRecord::Base
  belongs_to :estimate
  belongs_to :user

  validates_presence_of :estimate, :user
end
