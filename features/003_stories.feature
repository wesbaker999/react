Feature: Stories
  As a User
  I want to create stories
  So that I can define my project

  Scenario: Create a story
    Given I am logged in
      And there is a project called "Blog"
      And I am a "developer" on the project called "Blog"
      And I am viewing the project called "Blog"
    When I click "New Story"
      And I fill in "story[title]" with "Posts"
      And I select "User" from "story[actor_id]"
      And I fill in "story[description]" with "I want to write some stuff"
      And I press "Create"
    Then I should see "Story created"
      And I should see "#1: Posts"

  Scenario: View a story
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a story "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
    Then I should see "Comments"
      And I should see "As a User"
      And I should see "I want to do stuff"

  Scenario: Sign off a story
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a "developer" "Bob" on the project "Blog"
      And there is a story "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I press "Sign off as Client"
    Then I should see "Joe" within ".signatures .client"
      And there should be an outgoing email for "bob@example.com"

  Scenario: Edit a story
    Given I am logged in
      And there is a project called "Blog"
      And I am a "developer" on the project called "Blog"
      And there is a "client" "Dave" on the project "Blog"
      And there is a story "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "Edit Story"
      And I fill in "story[description]" with "I want to write stuff"
      And I press "Update"
    Then I should see "I want to write stuff"
      And I should not see "Dave" within ".signatures .client"
      And I should not see "Joe" within ".signatures .developer"
      And there should be an outgoing email for "dave@example.com"

  Scenario: Edit a story (no clients)
    Given I am logged in
      And there is a project called "Blog"
      And I am a "developer" on the project called "Blog"
      And there is a story "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "Edit Story"
      And I fill in "story[description]" with "I want to write stuff"
      And I press "Update"
    Then I should see "I want to write stuff"
      And I should not see "Joe" within ".signatures .developer"
      And there should not be any outgoing email

  Scenario: View a glossary term from a story
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a term "stuff" on the project "Blog"
      And there is a story "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "stuff" within "#content .description"
    Then I should see "stuff"
      And I should see "What it means"

  Scenario: View an actor from a story
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is an actor "Customer" on the project "Blog"
      And there is a story "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "Customer" within "#content .description"
    Then I should see "Customer"
      And I should see "Some guy"

  Scenario: Comment on a story
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a story "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I fill in "comment[body]" with "I have some things to say"
      And I press "Post Comment"
    Then I should see "I have some things to say" within "#comments"
      And I should see "Posted by: Joe" within "#comments"

  Scenario: Add a scenario to a story
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a story "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "New Scenario"
      And I fill in "scenario[title]" with "Do some specific things"
      And I fill in "scenario[description]" with "When I do specific things, Then I see other things"
      And I press "Create"
    Then I should see "Scenario created"
      And I should see "#1.1: Do some specific things" within "#scenarios"

  Scenario: Edit a scenario
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a story "Comments" on the project "Blog"
      And there is a scenario "Write one" for story "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "#1.1: Write one"
      And I fill in "scenario[title]" with "Write another"
      And I press "Update"
    Then I should see "Scenario updated"
      And I should see "#1.1: Write another" within "#scenarios"

  Scenario: Delete a scenario
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a story "Comments" on the project "Blog"
      And there is a scenario "Write one" for story "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "#1.1: Write one"
      And I click "Delete Scenario"
    Then I should see "Scenario deleted"
      And I should not see "#1.1: Write one"

  Scenario: View a glossary term from a scenario
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a story "Comments" on the project "Blog"
      And there is a term "thing" on the project "Blog"
      And there is a scenario "Write one" for story "Comments" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I click "thing" within "#scenarios .description"
    Then I should see "thing"
      And I should see "What it means"

  Scenario: View a linked story from a comment glossary term from a scenario
    Given I am logged in
      And there is a project called "Blog"
      And I am a "client" on the project called "Blog"
      And there is a story "Comments" on the project "Blog"
      And there is a story "Posts" on the project "Blog"
      And I am viewing the project called "Blog"
    When I click "Comments"
      And I fill in "comment[body]" with "See story #2 for more details"
      And I press "Post Comment"
      And I click "#2" within "#comments"
    Then I should see "Posts"
