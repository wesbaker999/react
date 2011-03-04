class ProjectsController < ApplicationController
  before_filter :load_project

  before_filter do
    @tab="projects"
  end

  def new
     @project = Project.new
  end

  def create
     @project = Project.new(params[:project])
     if @project.save
       @project.memberships.create(:user =>current_user, :admin => true, :developer => (params[:developer] == "1" ? true : false), :client => (params[:client] == "1" ? true : false))
       flash[:notice] = "Project created"
       redirect_to project_path(@project) and return
     end
     render :action => :new
   end

  def edit
     @tab="settings"
  end

  def update
    @tab="settings"
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project updated"
      redirect_to project_path(@project) and return
    end
    render :action => :edit
  end

  def generate_api_key
    @tab="settings"
    if @project.generate_api_key!
      flash[:notice] = "API key generated"
      redirect_to edit_project_path(@project) and return
    end
    render :action => :edit
  end

  def show
    redirect_to project_features_path(@project)
  end

  def index
     @projects = current_user.projects.alphabetical
  end

  private

  def load_project
    @project = Project.find(params[:id]) unless params[:id].blank?
    @membership = @project.memberships.for_user(current_user).first unless @project.blank?
  end
end