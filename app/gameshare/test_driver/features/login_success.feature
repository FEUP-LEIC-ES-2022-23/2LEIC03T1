Feature: Successful Login
  Login should work with valid credentials

  Scenario: Successful Login
    Given I am on the login page
    When I fill in "email" with "wrong"
    And I fill in "password" with "wrong"
    And I press "Login"
    Then I should see "Invalid email or password"