Feature: Books List

  As an automation developer
  I want to check the books list and details
  To check that a book is loaded correctly and with consistent information when added to the list

  Scenario: Access to books list
    Given I am on the login page
    When I fill the required fields of the login form
    And I click on the login button
    Then I will "redirect to" the "books" page
    And I can check the books attributes
