# Empty form

When('I leave the {string} field empty') do |field|
  wait_for_element_to_be_ready(:id, field)
  enter_text(:id, '', field)
end

And('I click some other field') do
  wait_for_element_to_be_ready(:id, 'unauth_container')
  click(:id, 'unauth_container')
end

Then('A {string} error message will pop up') do |error_message|
  wait_for_element_to_be_ready(:class, 'alert')
  expect(get_element_text(:class, 'alert')).to eq(error_message)
end

# Invalid information

When('I fill the {string} field with invalid information like: {string}') do |field, information|
  wait_for_element_to_be_ready(:id, field)
  enter_text(:id, information, field)
end
