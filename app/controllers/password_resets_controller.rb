class PasswordResetsController < ApplicationController
  # Method from: http://github.com/binarylogic/authlogic_example/blob/master/app/controllers/application_controller.rb
  skip_before_filter :login_required
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      PasswordResetMailer.reset(@user).deliver
      flash[:notice] = "Instructions to reset your password have been emailed to you"
      redirect_to root_path
    else
      flash.now[:notice] = "No user was found with email address #{params[:email]}"
      render :action => :new
    end
  end

  def edit
  end

  def update
    @user.password = @user.password_confirmation = params[:password]
    if !params[:password].blank? && @user.save
      flash[:notice] = "Your password was successfully updated"
      redirect_to "/signin"
    else
      render :action => :edit
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.first(:conditions => {:perishable_token => params[:id]})
    unless @user
      flash[:notice] = "We're sorry, but we could not locate your account"
      redirect_to root_url
    end
  end
end