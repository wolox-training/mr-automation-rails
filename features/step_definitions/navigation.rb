Given('I am on the login page') do
  navigate_to(ENV['URL'])
end

Then('I will {string} the {string} page') do |action, page|
  expected_element = get_expected_element(action, page)
  wait_for_element_to_display(:id, expected_element, 2)
  expect($driver.current_url).to eq(ENV['URL'] + "/#{page}")
end
