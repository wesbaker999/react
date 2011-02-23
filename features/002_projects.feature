Feature: Projects
  As a User
  I want to create and edit projects
  So that I can work on some stories

  Scenario: Create a project
    Given I am logged in
      And I am on the projects page
    When I click "New Project"
    Then I should see "New Project"
    When I fill in "project[name]" with "Blog"
      And I check "developer"
      And I press "Create"
    Then I should see "Blog"
      And I should see "New Story"

  Scenario: Edit project name
    Given I am logged in
      And there is a project called "Blog"
      And I am an "admin" on the project called "Blog"
      And I am viewing the project called "Blog"
    When I click "Settings" within "#sidebar"
      And I fill in "project[name]" with "CMS"
      And I press "Update"
    Then I should see "CMS"
      And I should not see "Blog"
