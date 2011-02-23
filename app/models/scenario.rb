class Scenario < ActiveRecord::Base

  belongs_to :story

  validates_presence_of :title, :description

  before_create :set_story_scenario_id

  def to_param
    self.story_scenario_id.to_s
  end

  protected

  def set_story_scenario_id
    self.story_scenario_id = self.story.next_story_scenario_id
  end
end