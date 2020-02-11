Before('@login') do
  click(:id, 'loggout') if $driver.current_url == (ENV['URL'] + '/books')
end
