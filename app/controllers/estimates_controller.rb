class EstimatesController < ApplicationController
  before_filter :load_project
  before_filter :new_estimate, :only => [:new, :create]
  before_filter :load_estimate, :only => [:show, :edit, :update, :destroy, :developer_sign, :client_sign]
  before_filter :update_estimate, :only => [:update]
  before_filter :add_stories, :only => [:new, :edit]

  before_filter do
    @tab="estimates"
  end

  def index
    @estimates = @project.estimates.by_updated_at
  end

  def show
  end

  def new
  end

  def create
    if params[:add_line_item]
      @estimate.line_items.build
      return render :action => :new
    end
    if @estimate.save
      flash[:notice] = "Estimate created"
      redirect_to project_estimate_path(@project, @estimate)
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if params[:add_line_item]
      @estimate.line_items.build
      return render :action => :edit
    end
    if @estimate.save
      flash[:notice] = "Estimate updated"
      redirect_to project_estimate_path(@project, @estimate)
    else
      render :action => :edit
    end
  end

  def destroy
    @estimate.destroy
    flash[:notice] = "Estimate deleted"
    redirect_to :action => :index
  end

  def developer_sign
    @estimate.developer_sign!(current_user)
    redirect_to project_estimate_path(@project, @estimate)
  end

  def client_sign
    @estimate.client_sign!(current_user)
    redirect_to project_estimate_path(@project, @estimate)
  end

  protected

  def load_project
    @project = Project.find(params[:project_id]) unless params[:project_id].blank?
    @membership = @project.memberships.for_user(current_user).first unless @project.blank?
    @meta_title << " - #{@project.name}" if @project
  end

  def new_estimate
    @estimate = @project.estimates.new(params[:estimate])
  end

  def update_estimate
    @estimate.attributes = params[:estimate]
  end

  def load_estimate
    @estimate = @project.estimates.find(params[:id])
  end

  def add_stories
    @project.stories.each do |story|
      unless @estimate.stories.include?(story)
        @estimate.story_estimates.build(:story => story)
      end
    end
  end
end