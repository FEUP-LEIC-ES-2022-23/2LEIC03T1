Feature: Show More/show less
  Text should start shorten and should be extended or shorten  when clicking in the show more/ show less button

 Scenario Outline: Clicking in the show more button and show less button
    Given I am in a game page
    And The description of a game is <description>
    Then It should be displayed <display>
    When I tap the <button> button
    Then It should be displayed <display2>
    When I tap the <button2> button
    Then It should display <display3>
   Examples:
     | description | display | button | display2 | button2 | display3 |
     | "<p>Very Useful text</ br></p>" | display | button | display2 | button2 | display3 |
