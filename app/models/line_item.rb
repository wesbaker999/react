class LineItem < ActiveRecord::Base
  belongs_to :estimate
  validates_presence_of :description, :min_hours, :max_hours

  scope :min_total, :select => "SUM(min_hours) AS total"
  scope :max_total, :select => "SUM(max_hours) AS total"
end