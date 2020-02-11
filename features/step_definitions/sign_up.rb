require 'faker'
require './services/helper.rb'

# Successful registration:

And('I click on the registration button') do
  wait_for_element_to_be_ready(:id, 'sign-up')
  click(:id, 'sign-up')
end

When('I fill the required fields of the registration form') do
  wait_for_form_fields(:id, %w[firstname lastname email password])
  enter_text(:id, Faker::Name.first_name, 'firstname')
  enter_text(:id, Faker::Name.last_name, 'lastname')
  enter_text(:id, Faker::Internet.email(domain: 'wolox.com.ar'), 'email')
  enter_text(:id, Faker::Internet.password, 'password')
end

And('I click on the submit button') do
  click(:id, 'submit_register')
end

# Unsuccessful registration: email already taken

When('I fill the required fields but the email already exists in the database') do
  wait_for_form_fields(:id, %w[firstname lastname email password])
  enter_text(:id, Faker::Name.first_name, 'firstname')
  enter_text(:id, Faker::Name.last_name, 'lastname')
  enter_text(:id, ENV['EXISTING_EMAIL'], 'email')
  enter_text(:id, Faker::Internet.password, 'password')
end
