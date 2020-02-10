require 'faker'
require './services/helper.rb'
# Navigation to sign up page:

Given('I am on the login page') do
  navigate_to(ENV['URL'])
end

And('I click on the registration button') do
  wait_for_element_to_be_ready(:id, 'sign-up')
  click(:id, 'sign-up')
end

# Successful registration:

When('I fill all the required fields') do
  wait_for_form_fields(:id, %w[firstname lastname email password])
  enter_text(:id, Faker::Name.first_name, 'firstname')
  enter_text(:id, Faker::Name.last_name, 'lastname')
  enter_text(:id, Faker::Internet.email(domain: 'wolox.com.ar'), 'email')
  enter_text(:id, Faker::Internet.password, 'password')
end

And('I click on the submit button') do
  click(:id, 'submit_register')
end

Then('I will be redirected to the login page') do
  wait_for_element_to_display(:id, 'login', 2)
  expect($driver.current_url).to eq(ENV['URL'] + '/login')
end

# Unsuccessful registration: Empty parameters

When('I leave the {string} field empty') do |field|
  wait_for_element_to_be_ready(:id, field)
  enter_text(:id, '', field)
end

And('I click some other field') do
  wait_for_element_to_be_ready(:id, 'unauth_container')
  click(:id, 'unauth_container')
end

Then('A {string} error message will pop up') do |error_message|
  alert = check_element_presence(:class, 'alert', true)
  expect(alert).to be(true)
  expect(get_element_text(:class, 'alert')).to eq(error_message)
end

And('I will not be redirected to the login page') do
  expect($driver.current_url).to eq(ENV['URL'] + '/sign-up')
end

# Unsuccessful registration: invalid email/password

When('I fill the {string} field with invalid information like: {string}') do |field, information|
  wait_for_element_to_be_ready(:id, field)
  enter_text(:id, information, field)
end

Then('A invalid {string} message will pop up') do |field|
  field += '_register_span'
  alert = check_element_presence(:id, field, true)
  expect(alert).to be(true)
end

# Unsuccessful registration: email already taken
When('I fill the required fields but the email already exists in the database') do
  wait_for_form_fields(:id, %w[firstname lastname email password])
  enter_text(:id, Faker::Name.first_name, 'firstname')
  enter_text(:id, Faker::Name.last_name, 'lastname')
  enter_text(:id, ENV['EXISTING_EMAIL'], 'email')
  enter_text(:id, Faker::Internet.password, 'password')
end

Then('An email already taken error message should pop up') do
  wait_for_element_to_display(:id, 'submit_error', 2)
  alert = check_element_presence(:id, 'submit_error', true)
  expect(alert).to be(true)
end
