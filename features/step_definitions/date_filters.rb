And('The list has no filters') do
  book_list = $driver.find_elements(:id, 'book_item')
  puts book_list
  original_book_list_count = get_books_names(book_list)
  puts original_book_list_count
end

When('I fill the from_date filter') do
  from_xpath = '//*[@id="search_picker"]/div/div/input'
  wait_for_element_to_be_ready(:xpath, from_xpath)
  click(:xpath, from_xpath)
  enter_text(:xpath, '01-01-2014', from_xpath)
end

And('I fill the until_date filter') do
  until_xpath = '//*[@id="date_picker"]/div/div/input'
  wait_for_element_to_be_ready(:xpath, until_xpath)
  click(:xpath, until_xpath)
  enter_text(:xpath, '12-31-2014', until_xpath)
end

Then('The book list will be updated') do
  pending # Write code here that turns the phrase above into concrete actions
end
