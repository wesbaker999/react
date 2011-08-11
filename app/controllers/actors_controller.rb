class ActorsController < ApplicationController
  before_filter :load_project
  before_filter :load_actor
  before_filter :require_membership

  def new
     @actor = @project.actors.new
  end

  def create
     @actor = @project.actors.new(params[:actor])
     respond_to do |format|
       format.html{
           if @actor.save
             flash[:notice] = t("txt.actors.actor_created")
             redirect_to project_actor_path(@project, @actor) and return
           end
           render :action => :new
        }
        format.js {
            @actor.save
        }
     end
   end

  def edit

  end

  def update
    if @actor.update_attributes(params[:actor])
      flash[:notice] = t("txt.actors.actor_updated")
      redirect_to project_actor_path(@project, @actor) and return
    end
    render :action => :edit
  end

  def destroy
    @actor.destroy
    redirect_to :back
  end

  private

  def load_actor
    @actor = Actor.find(params[:id]) unless params[:id].blank?
    @meta_title << @actor.name if @actor
  end

  def load_project
    @project = Project.find(params[:project_id]) unless params[:project_id].blank?
    render_not_found and return unless @project
    @membership = @project.memberships.for_user(current_user).first
    @meta_title << @project.name 
  end
end