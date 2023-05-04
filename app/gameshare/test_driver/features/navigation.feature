Feature: Navigation using the NavBar

  Scenario Outline: User navigates from one page to another
    Given I am on the <page> page
    When I click on the <icon> Button on NavBar
    Then I am on the top of <page2> Page

    Examples:
      | page | page2 | icon |
      | "Home" | "Search" | "Search" |
      | "Home" | "Login" | "User" |
      | "Search" | "Home" | "Home" |
      | "Search" | "Login" | "User" |
      | "Login" | "Home" | "Home" |
      | "Login" | "Search" | "Search" |


