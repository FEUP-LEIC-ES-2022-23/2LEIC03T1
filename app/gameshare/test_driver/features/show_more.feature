Feature: Show More Feature
  Clicking in the button show more should show all the game description and clicking in the show less button should show just a bit of the description

  Scenario: Clicking in the show more/less button
    Given I enter an game page
    And The description is shorten
    When  I click in the show button
    Then  I should see the "complete" description
    When I click in the show button
    Then I should see the "shorten" description









