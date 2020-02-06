Feature: Sign Up

  As an automation developer
  I want to create automated test for the diferent user registration cases
  So that i have a valid user to login to wBooks API

  Scenario: Successful registration
    Given I am on the login page
    And I click on the registration button
    When I fill all the required fields
    And I click on the submit button
    Then I will be redirected to the login page