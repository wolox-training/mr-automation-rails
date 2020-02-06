# frozen_string_literal: true

require 'faker'

Given('I am on the login page') do
  navigate_to('https://woloxbooksv3.firebaseapp.com/es')
end

And('I click on the registration button') do
  click(:id, 'sign-up')
end

When('I fill all the required fields') do
  enter_text(:id, Faker::Name.first_name, 'firstname')
  enter_text(:id, Faker::Name.last_name, 'lastname')
  enter_text(:id, Faker::Internet.email(domain: 'wolox.com.ar'), 'email')
  enter_text(:id, Faker::Internet.password, 'password')
end

And('I click on the submit button') do
  click(:id, 'submit_register')
end

Then('I will be redirected to the login page') do
  expect($driver.current_url).to eq('https://woloxbooksv3.firebaseapp.com/es/login')
end
