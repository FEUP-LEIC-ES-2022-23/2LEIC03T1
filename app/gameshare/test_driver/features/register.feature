Feature: Register
    Registering should be allowed if all fields are filled in correctly.

    Scenario: Register with valid data
        Given I am in the register page
        When I fill in "email_field_register" with "test@mail.com"
        And I fill in "username_field_register" with "test_user"
        And I fill in "password_field_register" with "test12345"
        And I fill in "confirm_password_field_register" with "test12345"
        And I tap the "Register" button
        Then I should see the home page

    Scenario: Register with invalid email
        Given I am in the register page
        When I fill in "email_field_register" with "test"
        And I fill in "username_field_register" with "test_user"
        And I fill in "password_field_register" with "test12345"
        And I fill in "confirm_password_field_register" with "test12345"
        And I tap the "Register" button
        Then I should see "Email is not valid"

    Scenario: Passwords don't match
        Given I am in the register page
        When I fill in "email_field_register" with "test@moremail.com"
        And I fill in "username_field_register" with "test_user"
        And I fill in "password_field_register" with "test12345"
        And I fill in "confirm_password_field_register" with "test123122"
        And I tap the "Register" button
        Then I should see "Passwords do not match"