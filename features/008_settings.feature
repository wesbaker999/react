Feature: "#8 Settings"
  As a User
  I want to edit my settings
  So I can change my site experience

  Scenario: Edit name
    Given I am logged in as "joe"
      And I am on the home page
    When I click "joe" within ".nav"
      And I fill in "user[name]" with "steve"
      And I press "Save"
    Then I should see "Settings saved"
      And I should see "steve" within ".nav"

  Scenario: Edit email
    Given I am logged in as "joe"
      And I am on the home page
    When I click "joe" within ".nav"
      And I fill in "user[email]" with "newjoe@example.com"
      And I press "Save"
    Then I should see "Settings saved"

  Scenario: Change time zone
    Given I am logged in as "joe"
      And I am on the home page
    When I click "joe" within ".nav"
      And I select "(GMT-08:00) Pacific Time (US & Canada)" from "user[time_zone]"
      And I press "Save"
    Then I should see "Settings saved"

  Scenario: Change locale
    Given I am logged in as "joe"
      And I am on the home page
    When I click "joe" within ".nav"
      And I select "de" from "user[locale]"
      And I press "Save"
    Then I should see "Settings saved"
