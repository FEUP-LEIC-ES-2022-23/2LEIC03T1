Feature: Login
  Login should work with valid credentials and fail with invalid credentials

  Scenario: Successful Login
    Given I am in the login page
    And I fill in "email_field_login" with my "email"
    And I fill in "password_field_login" with my "password"
    When I tap the "Login" button
    Then I should see my user page

  Scenario: Failed Login
    Given I am in the login page
    And I fill in "email_field_login" with "bad@email.com"
    And I fill in "password_field_login" with "badbunny"
    When I tap the "Login" button
    Then I should see "User not found"