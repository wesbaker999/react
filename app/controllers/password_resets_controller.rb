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
      flash[:notice] = t("txt.password_resets.instructions_have_been_emailed")
      redirect_to root_path
    else
      flash.now[:notice] = t("txt.password_resets.no_user_was_found", :email => params[:email])
      render :action => :new
    end
  end

  def edit
  end

  def update
    @user.password = @user.password_confirmation = params[:password]
    if !params[:password].blank? && @user.save
      flash[:notice] = t("txt.password_resets.password_updated")
      redirect_to "/signin"
    else
      render :action => :edit
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.first(:conditions => {:perishable_token => params[:id]})
    unless @user
      flash[:notice] = t("txt.password_resets.could_not_locate_account")
      redirect_to root_url
    end
  end
end