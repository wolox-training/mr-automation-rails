require 'faker'
require './services/helper.rb'

# Successful login

When('I fill the required fields of the login form') do
  wait_for_form_fields(:id, %w[email password])
  enter_text(:id, ENV['EXISTING_EMAIL'], 'email')
  enter_text(:id, ENV['EXISTING_PASSWORD'], 'password')
end

And('I click on the login button') do
  click(:id, 'login')
end

Then('I will be redirected to the user home page') do
  wait_for_element_to_display(:id, 'book_list_container', 2)
  expect($driver.current_url).to eq(ENV['URL'] + '/books')
end

# Unsuccessful login: right email but wrong password

When('I fill the required fields with unregistered credentials') do
  wait_for_form_fields(:id, %w[email password])
  enter_text(:id, Faker::Internet.email(domain: 'wolox.com.ar'), 'email')
  enter_text(:id, Faker::Internet.password, 'password')
end
