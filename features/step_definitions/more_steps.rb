Given /^(?:|I )am logged in$/ do
  @user = Factory.create(:user)
  @user.should be_valid
  visit "/signin"
  fill_in "user_session_email", :with => @user.email
  fill_in "user_session_password", :with => "password"
  click_button "Sign in"
  page.should have_content("Sign out")
end

Given /^there is a project called "([^"]+)"/ do |name|
  Factory.create(:project, :name => name)
end

Given /^I am viewing the project called "([^"]+)"/ do |name|
  project = Project.where(:name => name).first
  visit project_path(project)
end

Given /^I am a(?:n?) "([^"]+)" on the project called "([^"]+)"/ do |role, name|
  project = Project.where(:name => name).first
  project.memberships.create!(:user => @user, role => true)
end

Given /^there is a(?:n?) "([^"]+)" "([^"]+)" on the project "([^"]+)"/ do |role, user_name, project_name|
  user = Factory.create(:user, :name => user_name, :email => "#{user_name.downcase}@example.com")
  project = Project.where(:name => project_name).first
  project.memberships.create!(:user => user, role => true)
end

Given /^there is a story "([^"]+)" on the project "([^"]+)"/ do |title, name|
  project = Project.where(:name => name).first
  project.stories.create!(:title => title,
                          :description => "I want to do stuff so Customers can see things",
                          :actor => project.actors.where(:name => "User").first)
end

Given /^there is an estimate on the project "([^"]+)"/ do |name|
  project = Project.where(:name => name).first
  e = project.estimates.create!
  project.stories.each do |s|
    e.story_estimates.create!(:story => s, :min_hours => 2, :max_hours => 4)
  end
end

Given /^there is a scenario "([^"]+)" for story "([^"]+)" on the project "([^"]+)"/ do |scenario_title, story_title, project_name|
  project = Project.where(:name => project_name).first
  story = project.stories.where(:title => story_title).first
  story.scenarios.create!(:title => scenario_title,
                          :description => "When I do one thing, Then another thing happens")
end

Given /^there is a term "([^"]+)" on the project "([^"]+)"/ do |term, name|
  project = Project.where(:name => name).first
  project.glossary_terms.create!(:name => term,
                          :definition => "What it means")
end

Given /^there is a story "([^"]+)" for actor "([^"]+)" on the project "([^"]+)"/ do |title, actor_name, project_name|
  project = Project.where(:name => project_name).first
  actor = project.actors.where(:name => actor_name).first
  project.stories.create!(:title => title,
                          :description => "I want to do stuff",
                          :actor => actor)
end

Given /^there is an actor "([^"]+)" on the project "([^"]+)"/ do |actor_name, project_name|
  project = Project.where(:name => project_name).first
  project.actors.create!(:name => actor_name,
                         :description => "Some guy")
end

Given /^I have been invited with "([^"]+)" as a "([^"]+)" to the project "([^"]+)"$/ do |email, role_name, project_name|
  project = Project.where(:name => project_name).first
  project.invitations.create!(:email => email,
                              role_name => true)
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

Then /^there should be an outgoing email for "([^"]*)"$/ do |address|
  mail = ActionMailer::Base.deliveries.first
  mail.to.should == [address]
end

Then /^there should not be any outgoing email$/ do
  ActionMailer::Base.deliveries.should be_empty
end
