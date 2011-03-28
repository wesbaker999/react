class ProjectsController < ApplicationController
  before_filter :load_project

  before_filter :require_admin, :except => [:index, :show, :new, :create]

  skip_before_filter :login_required, :only =>[:show]

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
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project updated"
      redirect_to edit_project_path(@project) and return
    end
    render :action => :edit
  end

  def generate_api_key
    if @project.generate_api_key!
      flash[:notice] = "API key generated"
      redirect_to edit_project_path(@project) and return
    end
    render :action => :edit
  end

  def show
    render_not_found and return unless @project
    redirect_to root_url and return if !current_user and !@project.public?
    redirect_to project_features_path(@project)
  end

  def index
     @projects = current_user.projects.alphabetical
  end

  private

  def load_project
    @project = Project.find(params[:id]) unless params[:id].blank?
    @membership = @project.memberships.for_user(current_user).first if @project && current_user
  end

  def require_admin
    redirect_to project_features_path(@project) and return false unless @membership.admin?
  end
end