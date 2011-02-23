class UserSession < Authlogic::Session::Base
  def to_key
    id
  end
end