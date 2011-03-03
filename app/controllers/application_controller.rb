class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :login_required, :set_timezone

  helper_method :current_user_session, :current_user

  before_filter do
    @meta_title = ""
  end
     private
       def current_user_session
         return @current_user_session if defined?(@current_user_session)
         @current_user_session = UserSession.find
       end

       def current_user
         return @current_user if defined?(@current_user)
         @current_user = current_user_session && current_user_session.user
       end

  def login_required
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to '/signin'
      return false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def set_timezone
    unless cookies[:tzoffset].blank?
      Time.zone = ActiveSupport::TimeZone[-cookies[:tzoffset].to_i.minutes]
    end
  end
end