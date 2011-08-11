class NoRecipientsError < StandardError; end

class NotificationMailer < ActionMailer::Base
  default :from => "admin@reactualize.com"

  include ApplicationHelper

  def feature_updated(feature)
    @feature = feature
    member = feature.project.memberships.for_user(feature.updated_by).first
    recipient_members = feature.project.memberships.select do |m|
       (m.client? && member.developer?) || (m.developer? && member.client?)
    end
    raise NoRecipientsError.new if recipient_members.empty?
    recipients = recipient_members.collect{|m| m.user.email}
    mail(:to => recipients,
         :subject => t("txt.notification_mailer.feature_updated_subject", :project_name => feature.project.name, :project_feature_id => feature.project_feature_id, :title => feature.title, :updater_name => feature.updated_by.name))
  end

  def feature_signed_by_client(feature)
    @feature = feature
    recipients = feature.project.memberships.select{|m| m.developer?}.collect{|m| m.user.email}
    mail(:to => recipients,
         :subject => t("txt.notification_mailer.feature_signed_subject", :project_name => feature.project.name, :project_feature_id => feature.project_feature_id, :title => feature.title, :client_name => feature.client_signature.user.name))
  end
end
