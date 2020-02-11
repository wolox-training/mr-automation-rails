# Navigate to login

Given('I am on the login page') do
  navigate_to(ENV['URL'])
end

# Remain in current page

And('I will remain on the {string} page') do |page|
  expect($driver.current_url).to eq(ENV['URL'] + "/#{page}")
end

# Redirect to page

Then('I will be redirected to the {string} page') do |page|
  wait_for_element_to_display(:id, 'login', 2)
  expect($driver.current_url).to eq(ENV['URL'] + "/#{page}")
end
