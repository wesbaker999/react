class InvitationsController < ApplicationController
  before_filter :load_project
  before_filter :load_invitation
  skip_before_filter :login_required, :only => [:new,:show]

  def new
    @invitation = @project.invitations.new
  end

  def create
    @invitation = @project.invitations.create(params[:invitation])
    if @invitation.id.blank?
      flash[:notice] = "Invitation to this email address already exists"
    else
      flash[:notice] = "Invitation sent to #{@invitation.email}"
      InvitationMailer.invitation(@invitation).deliver

    end
    redirect_to project_memberships_path(@project)
  end

  def destroy
    @invitation.destroy
    flash[:notice] = "Invitation removed"
    redirect_to project_memberships_path(@project)
  end

  def show
    if @invitation.nil?
      flash[:notice] = "Invalid invitation code"
      redirect_to '/signin'
      return false
    end
    unless current_user
      store_location
      session[:invitation] = @invitation
      flash[:notice] = "You must have an account and be logged in to accept this invitation"
      redirect_to '/signin'
      return false
    end
    if current_user.email != @invitation.email
      flash[:notice] = "This invitation is invalid for this account"
      redirect_to "/"
      session.delete(:invitation)
      return
    end
  end

  def accept
    @invitation.accept!(current_user)
    session.delete(:invitation)
    redirect_to project_path(@invitation.project)
  end

  protected

  def load_project
    @project = Project.find(params[:project_id]) unless params[:project_id].blank?
  end

  def load_invitation
    @invitation = Invitation.find_by_uuid(params[:id]) unless params[:id].blank?
  end
end