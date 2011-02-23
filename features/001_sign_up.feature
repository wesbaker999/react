Feature: Sign up
  As a User
  I want to create an account
  So that I can use React

  Scenario: Successful sign up
    When I am on the home page
    Then I should see "Sign up"
    When I fill in "user[email]" with "test@test.com"
      And I fill in "user[name]" with "Test Name"
      And I fill in "user[password]" with "password"
      And I fill in "user[password_confirmation]" with "password"
      And I press "Sign up"
    Then I should see "Sign out"

  Scenario: Unsuccessful sign up
    When I am on the home page
    Then I should see "Sign up"
    When I fill in "user[email]" with "test@test1c"
      And I fill in "user[password]" with "password"
      And I fill in "user[password_confirmation]" with "password"
      And I press "Sign up"
    Then I should see "Email should look like an email address"

