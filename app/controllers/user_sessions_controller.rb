class UserSessionsController < ApplicationController

  skip_filter :login_required, :except => [:destroy]

  def new
    redirect_to projects_path and return if current_user
    @user_session = UserSession.new
    @user = User.new
    @user.email = @user_session.email = session[:invitation].email unless session[:invitation].blank?
  end

  def create
    @user = User.new
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_back_or_default '/'
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to signin_url
  end
end
