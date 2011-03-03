Feature: Features
  As a User
  I want to create features
  So that I can define my project

  Scenario: Create a feature
    Given I am logged in
      And there is a project called "Blog"
      And I am a "developer" on the project called "Blog"
      And I am viewing the project called "Blog"
    When I click "New Feature"
      And I fill in "feature[title]" with "Posts"
      And I select "User" from "feature[actor_id]"
      And I fill in "feature[description]" with "I want to write some stuff"
      And I press "Create"
    Then I should see "Feature created"
      And I should see "#1: Posts"

  Scenario: View a feature
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a feature "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
    Then I should see "Comments"
      And I should see "As a User"
      And I should see "I want to do stuff"

  Scenario: Sign off a feature
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a "developer" "Bob" on the project "Blog"
      And there is a feature "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I press "Sign off as Client"
    Then I should see "Joe" within ".signatures .client"
      And there should be an outgoing email for "bob@example.com"

  Scenario: Edit a feature
    Given I am logged in
      And there is a project called "Blog"
      And I am a "developer" on the project called "Blog"
      And there is a "client" "Dave" on the project "Blog"
      And there is a feature "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "Edit Feature"
      And I fill in "feature[description]" with "I want to write stuff"
      And I press "Update"
    Then I should see "I want to write stuff"
      And I should not see "Dave" within ".signatures .client"
      And I should not see "Joe" within ".signatures .developer"
      And there should be an outgoing email for "dave@example.com"

  Scenario: Edit a feature (no clients)
    Given I am logged in
      And there is a project called "Blog"
      And I am a "developer" on the project called "Blog"
      And there is a feature "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "Edit Feature"
      And I fill in "feature[description]" with "I want to write stuff"
      And I press "Update"
    Then I should see "I want to write stuff"
      And I should not see "Joe" within ".signatures .developer"
      And there should not be any outgoing email

  Scenario: View a glossary term from a feature
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a term "stuff" on the project "Blog"
      And there is a feature "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "stuff" within "#content .description"
    Then I should see "stuff"
      And I should see "What it means"

  Scenario: View an actor from a feature
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is an actor "Customer" on the project "Blog"
      And there is a feature "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "Customer" within "#content .description"
    Then I should see "Customer"
      And I should see "Some guy"

  Scenario: Comment on a feature
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a feature "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I fill in "comment[body]" with "I have some things to say"
      And I press "Post Comment"
    Then I should see "I have some things to say" within "#comments"
      And I should see "Posted by: Joe" within "#comments"
