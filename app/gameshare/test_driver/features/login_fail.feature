Feature: Fail Login
  Login should fail when the wrong credentials are used

  Scenario: Fail Login
    Given I am on the login page
    When I fill in "email" with "good_email"
    And I fill in "password" with "good_pwd"
    And I press "Login"
    Then I should not see "Invalid email or password"