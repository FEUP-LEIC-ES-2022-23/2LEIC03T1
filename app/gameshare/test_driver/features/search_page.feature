Feature: Search Page
  As any user
  I want to be able to search for games
  that fit in certain criteria

  Background:
    Given I am on the search page

  Scenario: Search for a game
    When I enter "Super Mario" in the search bar
    And I tap the search button
    Then I should see a list of games containing "Super Mario"

  Scenario: Cancel search
    Given I have entered a search query
    When I tap the cancel button
    Then the search bar should be cleared

  Scenario: Infinite scrolling
    Given there are many games to display
    When I reach the end of the list
    Then more games should be loaded

