# frozen_string_literal: true

require 'faker'

Given('I am on the login page') do
  navigate_to('https://woloxbooksv3.firebaseapp.com/es')
  wait(1)
end

And('I click on the registration button') do
  click(:id, 'sign-up')
  wait(1)
end

When('I fill out the following fields:') do |table|
  table.rows.each do |key|
    @field = key[0]
    case @field
    when 'firstname'
      @value = Faker::Name.first_name
    when 'lastname'
      @value = Faker::Name.last_name
    when 'email'
      @value = Faker::Internet.email(domain: 'wolox.com.ar')
    when 'password'
      @value = Faker::Internet.password
    end
    puts "#{@field}: #{@value}"
    enter_text(:id, @value, @field)
  end
end

And('I click on the submit button') do
  click(:id, 'submit_register')
end

Then('I will be redirected to the login page') do
  wait(2)
  expect($driver.current_url).to eq('https://woloxbooksv3.firebaseapp.com/es/login')
end
