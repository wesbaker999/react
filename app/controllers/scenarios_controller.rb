class ScenariosController < ApplicationController
  before_filter :load_project
  before_filter :load_story
  before_filter :load_scenario
  before_filter :load_counts

  helper :glossary_terms

  before_filter do
    @tab="stories"
  end

  def new
     @scenario = @story.scenarios.new
  end

  def create
     @scenario = @story.scenarios.new(params[:scenario])
     if @scenario.save
       flash[:notice] = "Scenario created"
       redirect_to project_story_path(@project, @story) and return
     end
     render :action => :new
  end

  def edit

  end

  def update
    if @scenario.update_attributes(params[:scenario])
      flash[:notice] = "Scenario updated"
      redirect_to project_story_path(@project, @story) and return
    end
    render :action => :edit
  end

  def destroy
    flash[:notice] = "Scenario deleted"
    @scenario.destroy
    redirect_to project_story_path(@project, @story)
  end

  private

  def load_scenario
    @scenario = @story.scenarios.find_by_story_scenario_id(params[:id]) unless params[:id].blank?
    @meta_title << " - ##{@scenario.story_scenario_id}: #{@scenario.title}" if @scenario
  end

  def load_story
    @story = @project.stories.find_by_project_story_id(params[:story_id]) unless params[:story_id].blank?
    @meta_title << " - ##{@story.project_story_id}: #{@story.title}" if @story
  end

  def load_project
    @project = Project.find(params[:project_id]) unless params[:project_id].blank?
    @membership = @project.memberships.for_user(current_user).first unless @project.blank?
    @meta_title << " - #{@project.name}" if @project
  end

  def load_counts
    @unsigned_count = @project.stories.unsigned_for(@membership).count
    @signed_count = @project.stories.signed.count
  end
end