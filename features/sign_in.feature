@login
Feature: Sign In

  As an automation developer
  I want to create automated test for the different user login cases
  So that testing time is reduced

  Scenario: Successful login
    Given I am on the login page
    When I fill the required fields of the login form
    And I click on the login button
    Then I will "redirect to" the "books" page

  Scenario Outline: Unsuccessful login: Empty parameters
    Given I am on the login page
    When I leave the "<field>" field empty
    And I click some other field
    And I click on the login button
    Then A "This field is required" error message will pop up
    And I will "remain in" the "login" page

    Examples:
      | field    |
      | email    |
      | password |

  Scenario Outline: Unsuccessful login: invalid email
    Given I am on the login page
    When I fill the "email" field with invalid information like: "<information>"
    And I click some other field
    And I click on the login button
    Then A "This is not an Email valid" error message will pop up
    And I will "remain in" the "login" page

    Examples:
      | information                |
      | invalid_mail               |
      | invalid mail@wolox.com.ar  |
      | invalid!&mail@wolox.com.ar |

  Scenario: Unsuccessful login: invalid password
    Given I am on the login page
    When I fill the "password" field with invalid information like: "bad password"
    And I click some other field
    And I click on the login button
    Then A "The password must not have spaces" error message will pop up
    And I will "remain in" the "login" page

  Scenario: Unsuccessful login: unregistered user
    Given I am on the login page
    When I fill the required fields with unregistered credentials
    And I click on the login button
    Then A "Credentials are incorrect" error message will pop up
    And I will "remain in" the "login" page
