@logged @current
Feature: Date Filter

  As an automation developer
  I want to create automation test for the search filters
  So that testing time is reduced

  Scenario: Applying 'from' and 'until'
    Given I have access to the book list
    And The list has no filters
    When I fill the from_date filter
    And I fill the until_date filter
    Then The book list will be updated