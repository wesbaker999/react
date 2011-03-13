Feature: "#5 Glossary"
  As a User
  I want to define terms in a glossary
  So that my features are consistent

  Scenario: Create a term
    Given I am logged in
      And there is a project called "Blog"
      And I am a "developer" on the project called "Blog"
      And I am viewing the project called "Blog"
    When I click "Glossary" within "#sidebar"
      And I click "New Term"
      And I fill in "glossary_term[name]" with "Homepage"
      And I fill in "glossary_term[definition]" with "The place where everything goes"
      And I press "Create"
    Then I should see "Term created"
      And I should see "Homepage"

  Scenario: Edit a term
    Given I am logged in
      And there is a project called "Blog"
      And there is a term "Homepage" on the project "Blog"
      And I am a "developer" on the project called "Blog"
      And I am viewing the project called "Blog"
    When I click "Glossary" within "#sidebar"
      And I click "Homepage"
      And I click "Edit Term"
      And I fill in "glossary_term[definition]" with "The page where the posts are"
      And I press "Update"
    Then I should see "Term updated"
      And I should see "Homepage"
