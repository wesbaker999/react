class PasswordResetMailer < ActionMailer::Base
  default :from => "admin@reactualize.com"

  def reset(user)
    @user = user
    mail(:to => @user.email,
         :subject => t("txt.password_reset_mailer.instructions"))
  end
end
