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
