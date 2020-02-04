# frozen_string_literal: true

require 'rubygems'
require 'selenium-cucumber'
require 'selenium-webdriver'
require 'dotenv'

Dotenv.load

# Store command line arguments
$browser_type = ENV.fetch('BROWSER', 'chrome')
$platform = ENV.fetch('PLATFORM', 'desktop')
$is_headless = ENV.fetch('HEADLESS', 'no')

# check for valid parameters
validate_parameters $platform, $browser_type, $app_path

# If platform is android or ios create driver instance for mobile browser
if $platform == 'android' || $platform == 'iOS'

  $browser_type = 'Browser' if $browser_type == 'native'

  $device_name, $os_version = get_device_info if $platform == 'android'

  desired_caps = {
    caps: {
      platformName: $platform,
      browserName: $browser_type,
      versionNumber: $os_version,
      deviceName: $device_name,
      udid: $udid,
      app: ".//#{$app_path}"
    }
  }

  begin
    $driver = Appium::Driver.new(desired_caps).start_driver
  rescue Exception => e
    puts e.message
    Process.exit(0)
  end
else
  begin
    chromedriver_path = File.join(File.absolute_path(''), 'chromedriver')
    Selenium::WebDriver::Chrome::Service.driver_path = chromedriver_path
    options = Selenium::WebDriver::Chrome::Options.new(
      args: [
        '--incognito',
        '--disable-popup-blocking',
        'binary_location=/var/task/bin/headless-chromium'
      ],
      prefs: { "disable-popup-blocking": 'true' }
    )
    $driver = Selenium::WebDriver.for(:chrome, options: options)
    url = ENV['URL']
    $driver.get(url)
    $driver.manage.window.maximize
  rescue Exception => e
    puts e.message
    Process.exit(0)
    $driver.quit
  end
end
