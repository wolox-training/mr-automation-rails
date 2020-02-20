@logged
Feature: Books List

  As an automation developer
  I want to check the books list and details
  To check that a book is loaded correctly and with consistent information when added to the list

  Background: I am logged in
    Given I am on the login page
    And I fill the required fields of the login form
    And I click on the login button
    And I will "redirect to" the "books" page

  Scenario: Access to books list
    Given I have access to the book list
    When All the books are displayed
    Then I can check all the books have a "title" attribute
    And I can check all the books have a "author" attribute
    And I can check all the books have a "image" attribute

  Scenario: Access to book details
    Given I have access to the book list
    When All the books are displayed
    And I click on any of the cards
    Then I will be redirected to the book details
    And I can check the book attributes

  Scenario: Navigate suggestions bar
    Given I have access to the book list
    When All the books are displayed
    And I click on any of the cards
    Then I will be redirected to the book details
    And I can check the suggestions bar shows four results
    And I can navigate "right" when i press the "next" button
    And I can navigate "left" when i press the "prev" button
