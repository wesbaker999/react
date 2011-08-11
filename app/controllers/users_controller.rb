class UsersController < ApplicationController
  skip_filter :login_required
  before_filter :new_user, :only => [:new,:create]

  def new
  end

  def create
    if @user.save
      current_user = @user
      redirect_back_or_default '/'
    else
      render :action => :new
    end
  end

  def dashboard
    redirect_to projects_path
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

      if @user.update_attributes(params[:user])
        flash[:notice] = t("txt.users.settings_saved")
      end
     render :action => :edit
  end

  private

  def new_user
    @user = User.new(params[:user])
  end
end