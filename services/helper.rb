def wait_for_form_fields(identifier, fields)
  fields.each do |field|
    wait_for_element_to_be_ready(identifier, field)
  end
end

def wait_for_element_to_be_ready(identifier, element)
  wait_for_element_to_display(identifier, element, 1)
  wait_for_element_to_enable(identifier, element, 1)
end

def get_expected_element(action, page)
  return redirect_expected_element(page) if action == 'redirect to'
  return remain_expected_element(page) if action == 'remain in'
end

def redirect_expected_element(page)
  return 'login_form' if page == 'login'
  return 'book_list' if page == 'books'
end

def remain_expected_element(page)
  return 'register_form' if page == 'sign-up'
  return 'login_form' if page == 'login'
end

def prepare_book(book_item)
  book = {}
  book_card_container = book_item.find_element(:id, 'book_card_container')
  %w[title author image].each do |element|
    book[element] = if element == 'image'
                      find_image(book_card_container)
                    else
                      book_card_container.find_element(:class, element)
                    end
  end
  book
end

def find_image(book_card_container)
  image_container = book_card_container.find_element(:id, 'book_card_image_container')
  image_container.find_element(:id, 'book_card_image')
end

def process_slide_element(slide_element)
  slide_element.attribute('aria-hidden')
end

def process_slides(slides)
  slides_activos = []
  contador = 0
  slides.each do |slide|
    contador += 1
    slides_activos.push(contador) unless process_slide_element(slide) == 'true'
  end
  slides_activos
end

def process_filter(date_filter)
  filter = {}
  case date_filter
  when 'from_date'
    filter[:xpath] = '//*[@id="search_picker"]/div/div/input'
    filter[:date] = '01-01-2014'
  when 'until_date'
    filter[:xpath] = '//*[@id="date_picker"]/div/div/input'
    filter[:date] = '12-31-2014'
  end
  filter
end

def total_amount_of_books
  book_count = 0
  next_arrow = $driver.find_element(:xpath, '//*[@id="next_arrow"]')
  while next_arrow.attribute(:class) != 'unable'
    book_items = $driver.find_elements(:id, 'book_item')
    book_count += book_items.length
    click(:xpath, '//*[@id="next_arrow"]')
  end
  book_items = $driver.find_elements(:id, 'book_item')
  book_count += book_items.length
  book_count
end

def apply_filters
  from_date_xpath = '//*[@id="search_picker"]/div/div/input'
  until_date_xpath = '//*[@id="date_picker"]/div/div/input'
  wait_for_element_to_be_ready(:xpath, from_date_xpath)
  check_element_text(:xpath, '', from_date_xpath, true)
  click(:xpath, from_date_xpath)
  enter_text(:xpath, '01-01-2014', from_date_xpath)
  wait_for_element_to_be_ready(:xpath, until_date_xpath)
  check_element_text(:xpath, '', until_date_xpath, true)
  click(:xpath, until_date_xpath)
  enter_text(:xpath, '12-31-2014', until_date_xpath)
end
