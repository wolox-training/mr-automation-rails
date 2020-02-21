And('The list has no filters') do
  @original_amount_of_books = total_amount_of_books
end

When('I fill the {string} filter') do |date_filter|
  filter = process_filter(date_filter)
  wait_for_element_to_be_ready(:xpath, filter[:xpath])
  check_element_text(:xpath, '', filter[:xpath], true)
  click(:xpath, filter[:xpath])
  enter_text(:xpath, filter[:date], filter[:xpath])
end

Then('The book list will be updated') do
  @filtered_amount_of_books = total_amount_of_books
  expect(@filtered_amount_of_books).not_to eq(@original_amount_of_books)
end

And("There won't be books with publication date previous to the filter date") do
  expect(@filtered_amount_of_books).to eq(15)
end

When('I fill the from_date with the latest publication date possible') do
  calendar_button_xpath = '//*[@id="search_picker"]/div/div/div/button'
  today_button_xpath = '//*[@id="search_picker"]/div/div[2]/table[1]/tr/td[2]/button'
  wait_for_element_to_be_ready(:xpath, calendar_button_xpath)
  click(:xpath, calendar_button_xpath)
  wait_for_element_to_be_ready(:xpath, today_button_xpath)
  click(:xpath, today_button_xpath)
end

And('The book list will be empty') do
  expect(@filtered_amount_of_books).to eq(0)
end

And('I apply filters') do
  apply_filters
end

When('I click the cross button') do
  from_filter_x_button_xpath = '//*[@id="search_picker"]/div/div/div/button[1]'
  until_filter_x_button_xpath = '//*[@id="date_picker"]/div/div/div/button[1]'
  wait_for_element_to_be_ready(:xpath, from_filter_x_button_xpath)
  click(:xpath, from_filter_x_button_xpath)
  wait_for_element_to_be_ready(:xpath, until_filter_x_button_xpath)
  click(:xpath, until_filter_x_button_xpath)
end

Then('The filters will be removed') do
  from_filter_xpath = '//*[@id="search_picker"]/div/div/input'
  until_filter_xpath = '//*[@id="date_picker"]/div/div/input'
  expect(get_element_text(:xpath, from_filter_xpath)).to be_empty
  expect(get_element_text(:xpath, until_filter_xpath)).to be_empty
end

And('The book list will be complete') do
  @current_amount_of_books = total_amount_of_books
  expect(@current_amount_of_books).to eq(@original_amount_of_books)
end
