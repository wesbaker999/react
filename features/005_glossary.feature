Feature: "#5 Glossary"
  As a User
  I want to define terms in a glossary
  So that my features are consistent

  Scenario: Create a term
    Given I am logged in
      And there is a project "Blog"
      And I am a "developer" on the project "Blog"
      And I am on the projects page
    When I click "Blog"
      And I click element "#glossary_tab img"
      And I click element "#add_term_button"
      And I fill in "glossary_term[name]" with "Homepage"
      And I fill in "glossary_term[definition]" with "The place where everything goes"
      And I press "Create"
    Then I should see "Homepage" within "#glossary"

  Scenario: Edit a term
    Given I am logged in
      And there is a project "Blog"
      And there is a term "Homepage" on the project "Blog"
      And I am a "developer" on the project "Blog"
      And I am on the projects page
    When I click "Blog"
      And I click element "#glossary_tab img"
      And I click "Edit" within "#glossary ul li:first-child"
      And I fill in "glossary_term[definition]" with "The page where the posts are" within "#edit_term"
      And I press "Update"
    Then I should see "The page where the posts are" within "#glossary"
