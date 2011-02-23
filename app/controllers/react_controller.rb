class ReactController < ApplicationController
  skip_filter :login_required
  def index
     redirect_to projects_path if current_user
  end
end