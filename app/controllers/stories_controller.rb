class StoriesController < ApplicationController
  before_filter :load_project
  before_filter :load_story
  before_filter :load_counts

  helper :glossary_terms

  before_filter do
    @tab="stories"
  end

  def index
    scope = @project.stories.scoped

    unless params[:q].blank?
      scope = scope.search(params[:q])
    end
    if params[:sort].blank? and !cookies["project_#{@project.id}_sort"].blank?
      params[:sort] = cookies["project_#{@project.id}_sort"]
    end
    if !params[:sort].blank? and (params[:sort] == "desc")
      scope = scope.by_id_desc
      @sort = "desc"
    else
      scope = scope.by_id
      @sort = "asc"
    end
    if params[:unsigned].blank? and !cookies["project_#{@project.id}_unsigned"].blank?
      params[:unsigned] = cookies["project_#{@project.id}_unsigned"]
    end
    if !params[:unsigned].blank? and (params[:unsigned] == "true")
      scope = scope.unsigned_for(@membership)
      @unsigned = "true"
    else
      @unsigned = "false"
    end
    cookies["project_#{@project.id}_sort"] = @sort
    cookies["project_#{@project.id}_unsigned"] = @unsigned
    @stories = scope.all
    @unsigned_count = @project.stories.unsigned_for(@membership).count
    @subtab = "Recent Activity"
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def new
     @story = @project.stories.new
  end

  def create
     @story = @project.stories.new(params[:story])
     @story.updated_by = current_user
     if @story.save
       flash[:notice] = "Story created"
       redirect_to project_story_path(@project, @story) and return
     end
     render :action => :new
   end

  def edit

  end

  def update
    @story.developer_signature_id = nil
    @story.client_signature_id = nil
    @story.updated_by = current_user
    if @story.update_attributes(params[:story])
      flash[:notice] = "Story updated"
      begin
        NotificationMailer.story_updated(@story).deliver
      rescue NoRecipientsError
      end
      redirect_to project_story_path(@project, @story) and return
    end
    render :action => :edit
  end

  def show

  end

  def destroy
    @story.destroy
    redirect_to :action => :index
  end

  def developer_sign
    @story.developer_sign!(current_user)
    @story.updated_by = current_user
    redirect_to project_story_path(@project,@story)
  end

  def client_sign
    @story.client_sign!(current_user)
    @story.updated_by = current_user
    NotificationMailer.story_signed_by_client(@story).deliver
    redirect_to project_story_path(@project,@story)
  end

  def comment
    if @story.comments.create(params[:comment].merge(:user => current_user))
      flash[:notice] = "Comment created"
      redirect_to project_story_path(@project, @story)
    else
      render :action => "show"
    end
  end

  private

  def load_story
    @story = @project.stories.find_by_project_story_id(params[:id]) unless params[:id].blank?
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