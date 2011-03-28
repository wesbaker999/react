Feature: "#4 Actors"
  As a User
  I want to create actors
  So that they can have features

  Scenario: Create an actor
    Given I am logged in
      And there is a project "Blog"
      And I am a "developer" on the project "Blog"
      And I am on the projects page
    When I click "Blog"
      And I click "ADD FEATURE"
      And I fill in "feature[title]" with "Posts"
      And I select "Add Actor" from "feature[actor_id]"
      And I fill in "feature_actor_name" with "Dude"
      And I fill in "feature[description]" with "I want to write some stuff"
      And I press "Create"
    Then I should see "Feature created"
      And I should see "#1: Posts"
      And I should see "As a Dude"

  Scenario: View features for an actor
    Given I am logged in
      And there is a project "Blog"
      And I am a "client" on the project "Blog"
      And there is an actor "Customer" on the project "Blog"
      And there is an actor "Admin" on the project "Blog"
      And there is a feature "Comments" for actor "Customer" on the project "Blog"
      And there is a feature "Management" for actor "Admin" on the project "Blog"
      And I am on the projects page
    When I click "Blog"
      And I click "Comments"
      And I click "Customer" within "#content .description"
    Then I should see "Comments"
      And I should not see "Management"
