class MembershipsController < ApplicationController
  before_filter :load_project
  before_filter :require_membership
  before_filter :require_membership_admin
  before_filter :load_membership

  def index
    if request.put?
      if @project.update_attributes(params[:project])
        flash[:notice] = t("txt.memberships.memberships_updated")
        redirect_to edit_project_path(@project) and return
      else
        render :action => "index"
      end
    end
  end

  def new
     @membership = @project.memberships.new
  end

  def create
     @membership = @project.memberships.new(params[:membership])
     if @membership.save
       flash[:notice] = t("txt.memberships.membership_created")
       redirect_to project_membership_path(@project, @membership) and return
     end
     render :action => :new
   end

  def edit

  end

  def update
    if @membership.update_attributes(params[:membership])
      flash[:notice] = t("txt.memberships.membership_updated")
      redirect_to project_membership_path(@project, @membership) and return
    end
    render :action => :edit
  end

  def show

  end

  def destroy
    @membership.destroy
    flash[:notice] = t("txt.memberships.membership_removed")
    redirect_to project_memberships_path(@project)
  end

  private

  def load_membership
    @membership = Membership.find(params[:id]) unless params[:id].blank?
  end

  def load_project
    @project = Project.find(params[:project_id]) unless params[:project_id].blank?
    render_not_found and return unless @project
    @membership = @project.memberships.for_user(current_user).first
  end
end