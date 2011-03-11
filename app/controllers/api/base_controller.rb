class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :login_required
  before_filter :verify_api_key

  layout false

  protected

  def verify_api_key
    unless @project = Project.where(:api_key => params[:api_key]).first
      render :json => nil, :status => :unauthorized
      return false
    end
  end
end