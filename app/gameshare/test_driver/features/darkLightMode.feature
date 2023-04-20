Feature: Dark Mode Light Mode
  The theme should change when the button is pressed

  Scenario Outline: Switching between modes
    Given I enter the app
    When  I tap on the mode icon <n> time
    Then  I switch to the <mode>.
    Examples:
      | n | mode |
      | 1 | "dark" |
      | 2 | "light" |
      | 3 | "dark" |








