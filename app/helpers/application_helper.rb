module ApplicationHelper
  def as_a_or_an(s)
    if !s.downcase.match(/^u(se|ni)/) and ['a','e','i','o','u'].include?(s.downcase[0..0] || "")
      return "As an"
    end
    "As a"
  end

  def errors_for(record)
    render :partial => "layouts/errors", :locals => {:record => record}
  end
end

