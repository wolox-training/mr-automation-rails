Given('I have access to the book list') do
  wait_for_element_to_be_ready(:xpath, '//*[@id="book_item"]')
end

When('All the books are displayed') do
  @book_list = $driver.find_elements(:id, 'book_item')
  @book_list.each do |book_item|
    book = prepare_book(book_item)
    wait_for_element_to_be_ready(:id, book['title'].attribute(:id))
    wait_for_element_to_be_ready(:id, book['author'].attribute(:id))
    wait_for_element_to_be_ready(:id, book['image'].attribute(:id))
  end
end

Then('I can check all the books have a {string} attribute') do |attribute|
  @book_list.each do |book_item|
    book = prepare_book(book_item)
    book_attribute_id = book[attribute].attribute(:id)
    expect(check_element_presence(:id, book_attribute_id, true)).to be(true)
    if attribute == 'image'
      book_image_src = book['image'].attribute(:src)
      expect(book_image_src).not_to be_empty
      expect(book_image_src.split('.').last).to eq('jpg').or eq('jpeg')
    else
      expect(book[attribute].text).not_to be_empty
    end
  end
end

When('I click on any of the cards') do
  clicked_book = @book_list.first
  book = prepare_book(clicked_book)
  @clicked_book_title = book['title'].text
  @clicked_book_author = book['author'].text
  click(:id, clicked_book.attribute(:id))
end

Then('I will be redirected to the book details') do
  author = get_element_text(:id, 'deatil_author').sub('Autor del libro: ', '')
  title = get_element_text(:id, 'book_tiitle').split(' (').first
  expect(check_element_presence(:id, 'detail', true)).to be(true)
  expect(title).to eq(@clicked_book_title)
  expect(author).to eq(@clicked_book_author)
end

And('I can check the book attributes') do
  details_ids = %w[book_tiitle deatil_author detail_publisher detail_year]
  details_ids.each do |detail_id|
    expect(check_element_presence(:id, detail_id, true)).to be(true)
  end
  expect(check_element_presence(:class, 'genre', true)).to be(true)
end

And('I can check the suggestions bar shows four results') do
  wait_for_element_to_be_ready(:class, 'carousel-inner')
  @book_slides = $driver.find_elements(:id, 'slide')
  @book_slides_activos = process_slides(@book_slides)
  expect(@book_slides_activos.length).to eq(4)
end

And('I can navigate {string} when i press the {string} button') do |_dir, direction|
  wait_for_element_to_be_ready(:class, "carousel-control-#{direction}")
  click(:class, "carousel-control-#{direction}")
  book_slides_previos = @book_slides_activos
  @book_slides_activos = process_slides(@book_slides)
  expect(@book_slides_activos).not_to match_array(book_slides_previos)
end
