class InvitationMailer < ActionMailer::Base
  default :from => "admin@reactualize.com"

  def invitation(invitation)
    @invitation = invitation
    mail(:to => @invitation.email,
         :subject => "You've been invited to join #{@invitation.project.name} on REACT")
  end
end
