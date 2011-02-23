class StoryEstimate < ActiveRecord::Base
  belongs_to :story
  belongs_to :estimate

  scope :min_total, :select => "SUM(min_hours) AS total"
  scope :max_total, :select => "SUM(max_hours) AS total"
end