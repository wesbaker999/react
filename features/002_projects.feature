Feature: "#2 Projects"
  As a User
  I want to create and edit projects
  So that I can work on some features

  Scenario: Create a project
    Given I am logged in
      And I am on the projects page
    When I click "ADD PROJECT"
    Then I should see "New Project"
    When I fill in "project[name]" with "Blog"
      And I check "developer"
      And I press "Create"
    Then I should see "Blog"
      And I should see "ADD FEATURE"

  Scenario: Edit project name
    Given I am logged in
      And there is a project "Blog"
      And I am an "admin" on the project "Blog"
      And I am on the projects page
    When I click "Blog"
      And I click element "#header .project_settings"
      And I fill in "project[name]" with "CMS"
      And I press "Save"
    Then I should see "Project updated"
      And I should see "CMS" within "#header h1"

  Scenario: Generate new project API key
    Given I am logged in
      And there is a project "Blog"
      And I am an "admin" on the project "Blog"
      And I am on the projects page
    When I click "Blog"
      And I click element "#header .project_settings"
      And I press "Generate new API key"
    Then I should see "API key generated"

  Scenario: Public Project
    Given I am not logged in
      And there is a public project "Open"
      And I visit the project "Open"
    Then I should see "Open"
      And I should not see "ADD FEATURE"
      And I should not see "Sign out"
      And I should see "Sign in"
      And I should see "Sign up"
      And I should not see "ADD TERM"
