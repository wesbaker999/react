class ActorsController < ApplicationController
  before_filter :load_project
  before_filter :load_actor

  before_filter do
    @tab="actors"
  end

  def index
    @actors = @project.actors.alphabetical
  end

  def new
     @actor = @project.actors.new
  end

  def create
     @actor = @project.actors.new(params[:actor])
     if @actor.save
       flash[:notice] = "Actor created"
       redirect_to project_actor_path(@project, @actor) and return
     end
     render :action => :new
   end

  def edit

  end

  def update
    if @actor.update_attributes(params[:actor])
      flash[:notice] = "Actor updated"
      redirect_to project_actor_path(@project, @actor) and return
    end
    render :action => :edit
  end

  def show

  end

  def destroy
    @actor.destroy
    redirect_to :action => :index
  end

  private

  def load_actor
    @actor = Actor.find(params[:id]) unless params[:id].blank?
    @meta_title << "- #{@actor.name}" if @actor
  end

  def load_project
    @project = Project.find(params[:project_id]) unless params[:project_id].blank?
    @membership = @project.memberships.for_user(current_user).first unless @project.blank?
    @meta_title << " - #{@project.name}" if @project
  end
end