Then('I can check the books attributes') do
  wait(5)
  wait_for_element_to_be_ready(:id, 'book_list')
  book_list = $driver.find_elements(:id, 'book_item')
  book_list.each do |book_item|
    book = prepare_book(book_item)
    expect(is_element_displayed(:id, book['title'].attribute(:id))).to be(true)
    expect(is_element_displayed(:id, book['author'].attribute(:id))).to be(true)
    expect(is_element_displayed(:id, book['image'].attribute(:id))).to be(true)
  end
end
