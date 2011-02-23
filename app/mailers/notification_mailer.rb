class NoRecipientsError < StandardError; end

class NotificationMailer < ActionMailer::Base
  default :from => "admin@reactualize.com"

  def story_updated(story)
    @story = story
    member = story.project.memberships.for_user(story.updated_by).first
    recipient_members = story.project.memberships.select do |m|
       (m.client? && member.developer?) || (m.developer? && member.client?)
    end
    raise NoRecipientsError.new if recipient_members.empty?
    recipients = recipient_members.collect{|m| m.user.email}
    mail(:to => recipients,
         :subject => "[#{story.project.name}] Story ##{story.project_story_id} \"#{story.title}\" updated by #{story.updated_by.name}")
  end

  def story_signed_by_client(story)
    @story = story
    recipients = story.project.memberships.select{|m| m.developer?}.collect{|m| m.user.email}
    mail(:to => recipients,
         :subject => "[#{story.project.name}] Story ##{story.project_story_id} \"#{story.title}\" signed by client #{story.client_signature.user.name}")
  end
end
