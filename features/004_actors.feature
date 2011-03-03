Feature: Actors
  As a User
  I want to create actors
  So that they can have features

  Scenario: Create an actor
    Given I am logged in
      And there is a project called "Blog"
      And I am a "developer" on the project called "Blog"
      And I am viewing the project called "Blog"
    When I click "Actors" within "#sidebar"
      And I click "New Actor"
      And I fill in "actor[name]" with "Customer"
      And I fill in "actor[description]" with "Person who buys stuff"
      And I press "Create"
    Then I should see "Actor created"
      And I should see "Customer"

  Scenario: Edit an actor
    Given I am logged in
      And there is a project called "Blog"
      And there is an actor "Dave" on the project "Blog"
      And I am a "developer" on the project called "Blog"
      And I am viewing the project called "Blog"
    When I click "Actors" within "#sidebar"
      And I click "Dave"
      And I click "Edit Actor"
      And I fill in "actor[name]" with "Steve"
      And I press "Update"
    Then I should see "Steve"
      And I should not see "Dave"

  Scenario: View features for an actor
    Given I am logged in
      And there is a project called "Blog"
      And there is an actor "Dave" on the project "Blog"
      And there is a feature "Comments" for actor "Dave" on the project "Blog"
      And I am a "developer" on the project called "Blog"
      And I am viewing the project called "Blog"
    When I click "Actors" within "#sidebar"
      And I click "Dave"
    Then I should see "Dave"
      And I should see "Comments"
