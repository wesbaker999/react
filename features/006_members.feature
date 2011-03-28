Feature: "#6 Members"
  As an Admin
  I want to manage project members
  So that others can work on the project

  Scenario: Add a member
    Given I am logged in
      And there is a project "Blog"
      And I am an "admin" on the project "Blog"
      And I am on the projects page
    When I click "Blog"
      And I click element "#header .project_settings"
      And I press "Add Member"
      And I fill in "invitation[email]" with "newguy@example.com"
      And I check "invitation[developer]"
      And I press "Invite New Member"
    Then I should see "Invitation sent to newguy@example.com"
      And I should see "newguy@example.com" within "#invitations"
      And there should be an outgoing email for "newguy@example.com"

  Scenario: Change a member's role
    Given I am logged in
      And there is a project "Blog"
      And I am an "admin" on the project "Blog"
      And I am on the projects page
    When I click "Blog"
      And I click element "#header .project_settings"
      And I check "project[memberships_attributes][0][developer]" within ".edit_project tbody tr:first-child"
      And I press "Update Memberships"
    Then I should see "Memberships updated"

  Scenario: Remove a member
    Given I am logged in
      And there is a project "Blog"
      And I am an "admin" on the project "Blog"
      And I am on the projects page
      And there is a "developer" "Dave" on the project "Blog"
    When I click "Blog"
      And I click element "#header .project_settings"
      And I accept the confirmation dialog
      And I click "Remove" within ".edit_project tbody tr:nth-child(2)"
    Then I should see "Membership removed"
      And I should not see "Dave" within ".edit_project"

  Scenario: Remove an invitation
    Given I am logged in
      And there is a project "Blog"
      And I am an "admin" on the project "Blog"
      And I am on the projects page
    When I click "Blog"
      And I click element "#header .project_settings"
      And I press "Add Member"
      And I fill in "invitation[email]" with "newguy@example.com"
      And I check "invitation[developer]"
      And I press "Invite New Member"
    Then I should see "Invitation sent to newguy@example.com"
      And I should see "newguy@example.com" within "#invitations"
    When I accept the confirmation dialog
      And I click "Remove" within "#invitations"
    Then I should see "Invitation removed"

  Scenario: Accept an invitation
    Given there is a project "Blog"
      And I have been invited with "newguy@example.com" as a "developer" to the project "Blog"
      And I am on the home page
    When I click "Sign up"
      And I fill in "user[name]" with "New Guy"
      And I fill in "user[email]" with "newguy@example.com"
      And I fill in "user[password]" with "password"
      And I fill in "user[password_confirmation]" with "password"
      And I press "Sign up"
    Then I should see "New Guy" within "#header .nav"
    When I visit the invitation for "newguy@example.com" to the project "Blog"
      And I press "Accept invitation to project: Blog"
    Then I should see "Blog" within "#header h1"

  Scenario: Invalid invitation
    When I visit an invalid invitation
    Then I should see "Invalid invitation code"
