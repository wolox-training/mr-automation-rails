Before('@login or @logged') do
  click(:id, 'loggout') if $driver.current_url == (ENV['URL'] + '/books')
end

Before('@logged') do
  navigate_to(ENV['URL'])
  wait_for_form_fields(:id, %w[email password])
  enter_text(:id, ENV['EXISTING_EMAIL'], 'email')
  enter_text(:id, ENV['EXISTING_PASSWORD'], 'password')
  wait_for_element_to_display(:id, 'login', 1)
  click(:id, 'login')
end

After do
  $driver.manage.delete_all_cookies
  $driver.local_storage.clear
  sleep 1
end
