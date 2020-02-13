Feature: Sign Up

  As an automation developer
  I want to create automated test for the diferent user registration cases
  So that i have a valid user to login to wBooks API

  Scenario: Successful registration
    Given I am on the login page
    And I click on the registration button
    When I fill the required fields of the registration form
    And I click on the submit button
    Then I will "redirect to" the "login" page

  Scenario Outline: Unsuccessful registration: Empty parameters
    Given I am on the login page
    And I click on the registration button
    When I leave the "<field>" field empty
    And I click some other field
    And I click on the submit button
    Then A "This field is required" error message will pop up
    And I will "remain in" the "sign-up" page

    Examples:
      | field     |
      | firstname |
      | lastname  |
      | email     |
      | password  |

  Scenario Outline: Unsuccessful registration: invalid email
    Given I am on the login page
    And I click on the registration button
    When I fill the "email" field with invalid information like: "<information>"
    And I click some other field
    And I click on the submit button
    Then A "This is not an Email" error message will pop up
    And I will "remain in" the "sign-up" page

    Examples:
      | information                |
      | invalid_mail               |
      | invalid mail@wolox.com.ar  |
      | invalid!&mail@wolox.com.ar |

  Scenario: Unsuccessful registration: invalid password
    Given I am on the login page
    And I click on the registration button
    When I fill the "password" field with invalid information like: "bad password"
    And I click some other field
    And I click on the submit button
    Then A "The password must not have spaces" error message will pop up
    And I will "remain in" the "sign-up" page

  Scenario: Unsuccessful registration: email already taken
    Given I am on the login page
    And I click on the registration button
    When I fill the required fields but the email already exists in the database
    And I click on the submit button
    Then A "Email has already been taken" error message will pop up
    And I will "remain in" the "sign-up" page
