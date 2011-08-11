class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :login_required, :set_timezone, :set_locale

  helper_method :current_user_session, :current_user

  before_filter do
    @meta_title = ["REACT"]
  end

  protected

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
      flash[:notice] = t("txt.nav.must_be_logged_in")
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
    Time.zone = current_user.time_zone and return if current_user && !current_user.time_zone.blank?
    unless cookies[:tzoffset].blank?
      Time.zone = ActiveSupport::TimeZone[-cookies[:tzoffset].to_i.minutes]
    end
  end

  def set_locale
    I18n.locale = current_user.try(:locale) || I18n.default_locale
  end

  def render_not_found
    render :file => "public/404.html", :layout => false, :status => 404
  end

  def require_membership
    unless @membership
      flash[:notice] = t("txt.nav.membership_required")
      redirect_to root_url
    end
  end

  def require_membership_admin
    unless @membership.admin?
      flash[:notice] = t("txt.nav.must_be_admin")
      redirect_to project_path(@project)
    end
  end
end
