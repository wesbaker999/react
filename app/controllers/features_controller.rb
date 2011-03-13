class FeaturesController < ApplicationController
  before_filter :load_project
  before_filter :load_feature
  before_filter :load_counts

  helper :glossary_terms

  before_filter do
    @tab="features"
  end

  def index
    scope = @project.features.scoped

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
    @features = scope.all
    @unsigned_count = @project.features.unsigned_for(@membership).count
    @subtab = "Recent Activity"
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def new
     @feature = @project.features.new
  end

  def create
     @feature = @project.features.new(params[:feature])
     @feature.updated_by = current_user
     if @feature.save
       flash[:notice] = "Feature created"
       redirect_to project_feature_path(@project, @feature) and return
     end
     render :action => :new
   end

  def edit

  end

  def update
    @feature.developer_signature_id = @feature.client_signature_id = @feature.test_report = nil
    @feature.num_tests = @feature.num_failures = 0
    @feature.updated_by = current_user
    if @feature.update_attributes(params[:feature])
      flash[:notice] = "Feature updated"
      begin
        NotificationMailer.feature_updated(@feature).deliver
      rescue NoRecipientsError
      end
      redirect_to project_feature_path(@project, @feature) and return
    end
    render :action => :edit
  end

  def show

  end

  def destroy
    @feature.destroy
    redirect_to :action => :index
  end

  def developer_sign
    @feature.developer_sign!(current_user)
    @feature.updated_by = current_user
    redirect_to project_feature_path(@project,@feature)
  end

  def client_sign
    @feature.client_sign!(current_user)
    @feature.updated_by = current_user
    NotificationMailer.feature_signed_by_client(@feature).deliver
    redirect_to project_feature_path(@project,@feature)
  end

  def comment
    if @feature.comments.create(params[:comment].merge(:user => current_user))
      flash[:notice] = "Comment created"
      redirect_to project_feature_path(@project, @feature)
    else
      render :action => "show"
    end
  end

  private

  def load_feature
    @feature = @project.features.find_by_project_feature_id(params[:id]) unless params[:id].blank?
    @meta_title << " - ##{@feature.project_feature_id}: #{@feature.title}" if @feature
  end

  def load_project
    @project = Project.find(params[:project_id]) unless params[:project_id].blank?
    @membership = @project.memberships.for_user(current_user).first unless @project.blank?
    @meta_title << " - #{@project.name}" if @project
  end

  def load_counts
    @unsigned_count = @project.features.unsigned_for(@membership).count
    @signed_count = @project.features.signed.count
  end
end