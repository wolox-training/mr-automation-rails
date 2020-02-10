def wait_for_form_fields(identifier, fields)
  fields.each do |field|
    wait_for_element_to_be_ready(identifier, field)
  end
end

def wait_for_element_to_be_ready(identifier, element)
  wait_for_element_to_display(identifier, element, 1)
  wait_for_element_to_enable(identifier, element, 1)
end
