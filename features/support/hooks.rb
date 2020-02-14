Before('@login') do
  click(:id, 'loggout') if $driver.current_url == (ENV['URL'] + '/books')
end

After do
  $driver.manage.delete_all_cookies
  $driver.local_storage.clear
  sleep 1
end
