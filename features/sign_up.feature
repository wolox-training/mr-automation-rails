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

  Scenario Outline: Unsuccessful registration: Empty parameters
    Given I am on the login page
    And I click on the registration button
    When I leave the "<field>" field empty
    And I click some other field
    And I click on the submit button
    Then A "This field is required" error message will pop up
    And I will not be redirected to the login page

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
    Then A invalid "email" message will pop up
    And I will not be redirected to the login page

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
    Then A invalid "password" message will pop up
    And I will not be redirected to the login page

  Scenario: Unsuccessful registration: email already taken
    Given I am on the login page
    And I click on the registration button
    When I fill the required fields but the email already exists in the database
    And I click on the submit button
    Then An email already taken error message should pop up
    And I will not be redirected to the login page
