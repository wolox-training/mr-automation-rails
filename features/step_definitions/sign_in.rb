require 'faker'
require './services/helper.rb'

# Successful login

When('I fill the required fields of the login form') do
  wait_for_form_fields(:id, %w[email password])
  enter_text(:id, ENV['EXISTING_EMAIL'], 'email')
  enter_text(:id, ENV['EXISTING_PASSWORD'], 'password')
end

And('I click on the login button') do
  wait_for_element_to_display(:id, 'login', 1)
  click(:id, 'login')
end

# Unsuccessful login: unregistered credentials

When('I fill the required fields with unregistered credentials') do
  wait_for_form_fields(:id, %w[email password])
  enter_text(:id, Faker::Internet.email(domain: 'wolox.com.ar'), 'email')
  enter_text(:id, Faker::Internet.password, 'password')
end
