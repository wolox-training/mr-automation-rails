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

def get_books_names(book_elements_list)
  array_of_names = []
  book_elements_list.each do |book_element|
    container = book_element.find_element(:xpath, '//*[@id="book_card_container"]')
    book_title = container.find_element(:xpath, '//*[@id="book_card_title"]')
    puts book_title.text
    array_of_names.push(book_title)
  end
  array_of_names
end
