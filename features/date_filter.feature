@logged
Feature: Date Filter

  As an automation developer
  I want to create automation test for the search filters
  So that testing time is reduced

  Scenario: Applying 'from' and 'until' filters
    Given I have access to the book list
    And The list has no filters
    When I fill the "from_date" filter
    And I fill the "until_date" filter
    Then The book list will be updated

  Scenario: Applying only 'from' filter
    Given I have access to the book list
    And The list has no filters
    When I fill the "from_date" filter
    Then The book list will be updated
    And There won't be books with publication date previous to the filter date

  Scenario: Applying 'from' filter with the latest publication date possible
    Given I have access to the book list
    And The list has no filters
    When I fill the from_date with the latest publication date possible
    Then The book list will be updated
    And The book list will be empty

  Scenario: Removing filters
    Given I have access to the book list
    And The list has no filters
    And I apply filters
    When I click the cross button
    Then The filters will be removed
    And The book list will be complete
