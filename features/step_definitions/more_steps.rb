def log_in_as(user)
  @user.should be_valid
  visit "/signin"
  fill_in "user_session_email", :with => @user.email
  fill_in "user_session_password", :with => "password"
  click_button "Sign in"
  page.should have_content("Sign out")
end

Given /^(?:|I )am logged in$/ do
  @user = Factory.create(:user)
  log_in_as(@user)
end

Given /^(?:|I )am logged in as "([^"]+)"$/ do |name|
  @user = Factory.create(:user, :name => name)
  log_in_as(@user)
end

Given /^(?:|I )am not logged in$/ do
  visit '/signout'
  page.should have_content("Sign in")
end

Given /^there is a project "([^"]+)"/ do |name|
  Factory.create(:project, :name => name)
end

Given /^there is a public project "([^"]+)"/ do |name|
  Factory.create(:project, :name => name, :public => true)
end

Given /^I visit the project "([^"]+)"/ do |name|
  project = Project.where(:name => name).first
  visit project_path(project)
end

Given /^I am a(?:n?) "([^"]+)" on the project "([^"]+)"/ do |role, name|
  project = Project.where(:name => name).first
  project.memberships.create!(:user => @user, role => true)
end

Given /^there is a(?:n?) "([^"]+)" "([^"]+)" on the project "([^"]+)"/ do |role, user_name, project_name|
  user = Factory.create(:user, :name => user_name, :email => "#{user_name.downcase}@example.com")
  project = Project.where(:name => project_name).first
  project.memberships.create!(:user => user, role => true)
end

Given /^there is a feature "([^"]+)" on the project "([^"]+)"/ do |title, name|
  project = Project.where(:name => name).first
  project.features.create!(:title => title,
                          :description => "I want to do stuff so Customers can see things",
                          :actor => project.actors.where(:name => "User").first)
end

Given /^there is an estimate on the project "([^"]+)"/ do |name|
  project = Project.where(:name => name).first
  e = project.estimates.create!
  project.features.each do |s|
    e.feature_estimates.create!(:feature => s, :min_hours => 2, :max_hours => 4)
  end
end

Given /^there is a term "([^"]+)" on the project "([^"]+)"/ do |term, name|
  project = Project.where(:name => name).first
  project.glossary_terms.create!(:name => term,
                          :definition => "What it means")
end

Given /^there is a feature "([^"]+)" for actor "([^"]+)" on the project "([^"]+)"/ do |title, actor_name, project_name|
  project = Project.where(:name => project_name).first
  actor = project.actors.where(:name => actor_name).first
  project.features.create!(:title => title,
                          :description => "I want to do stuff",
                          :actor => actor)
end

Given /^there is an actor "([^"]+)" on the project "([^"]+)"/ do |actor_name, project_name|
  project = Project.where(:name => project_name).first
  project.actors.create!(:name => actor_name)
end

Given /^I have been invited with "([^"]+)" as a "([^"]+)" to the project "([^"]+)"$/ do |email, role_name, project_name|
  project = Project.where(:name => project_name).first
  project.invitations.create!(:email => email,
                              role_name => true)
end

When /^(?:|I )click element "([^"]*)"$/ do |selector|
  page.find(selector).click
end

When /^(?:|I )click "([^"]*)" within "([^"]*)"$/ do |link, selector|
  with_scope(selector) do
    click_link(link)
  end
end

When /^I visit the invitation for "([^"]+)" to the project "([^"]+)"$/ do |email, project_name|
  project = Project.where(:name => project_name).first
  invitation = project.invitations.where(:email => email).first
  visit invitation_path(invitation)
end

When /^I visit an invalid invitation$/ do
  visit invitation_path("invalid")
end

When /^I click the first estimate for the project "([^"]*)"$/ do |name|
  project = Project.where(:name => name).first
  click_link("view_estimate_#{project.estimates.first.id}")
end

# NOTE - you must call this step BEFORE the step that generates the dialog
When /^I accept the confirmation dialog$/ do
  page.evaluate_script("window.confirm = function() { return true; }")
end

Then /^there should be an outgoing email for "([^"]*)"$/ do |address|
  mail = ActionMailer::Base.cached_deliveries.first
  mail.to.should == [address]
end

Then /^there should not be any outgoing email$/ do
  ActionMailer::Base.cached_deliveries.should be_empty
end
