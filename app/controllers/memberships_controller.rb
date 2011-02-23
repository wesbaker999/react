class MembershipsController < ApplicationController
  before_filter :load_project
  before_filter :load_membership

  before_filter do
    @tab="members"
  end

  def index
    if request.put?
      if @project.update_attributes(params[:project])
        flash[:notice] = "Memberships updated"
        redirect_to project_memberships_path(@project) and return
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
       flash[:notice] = "Membership created"
       redirect_to project_membership_path(@project, @membership) and return
     end
     render :action => :new
   end

  def edit

  end

  def update
    if @membership.update_attributes(params[:membership])
      flash[:notice] = "Membership updated"
      redirect_to project_membership_path(@project, @membership) and return
    end
    render :action => :edit
  end

  def show

  end

  def destroy
    @membership.destroy
    flash[:notice] = "Membership removed"
    redirect_to project_memberships_path(@project)
  end

  private

  def load_membership
    @membership = Membership.find(params[:id]) unless params[:id].blank?
  end

  def load_project
    @project = Project.find(params[:project_id]) unless params[:project_id].blank?
    @membership = @project.memberships.for_user(current_user).first unless @project.blank?
  end
end