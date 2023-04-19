Feature: Login
  Login should work with valid credentials and fail with invalid credentials

  Scenario: Successful Login
    Given I am in the login page
    When I fill in "email_field_login" with "gs@gs.com"
    When I fill in "password_field_login" with "gameshare"
    When I tap the "Login" button
    Then I should see the home page

  Scenario: Failed Login
    Given I am in the login page
    When I fill in "email_field_login" with "bad@email.com"
    When I fill in "password_field_login" with "badbunny"
    When I tap the "Login" button
    Then I should see "Invalid email or password"