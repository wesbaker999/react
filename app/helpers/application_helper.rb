module ApplicationHelper
  def errors_for(record)
    render :partial => "layouts/errors", :locals => {:record => record}
  end

  def current_admin?
    @project && @membership && @membership.admin?
  end
end

