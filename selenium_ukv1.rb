#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'headless'
require 'fileutils'

headless = Headless.new
headless.start
#headless.video.start_capture
client = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 300
driver = Selenium::WebDriver.for(:firefox, :http_client => client) 
retval = 0
screenfile = "#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.png"
vidfile = "#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.mov"
retry_count = 5

FileUtils.mkdir_p 'mail'
FileUtils.rm_rf(Dir.glob('mail/*'))

driver.manage.window.maximize
driver.manage.timeouts.page_load = 120
driver.manage.timeouts.implicit_wait = 120 

def teardown(headless,driver,screenfile,vidfile,retval)
  driver.save_screenshot("#{screenfile}")
  #headless.video.stop_and_save("#{vidfile}")
  FileUtils.cp("#{screenfile}", "mail")
  #FileUtils.cp("#{vidfile}", "mail")
  driver.quit
  headless.destroy
  exit retval  
end



# Access thomascook.com
begin
  driver.navigate.to "http://ww1.thomascook.com"
rescue => exception
  retry_count -= 1
  if retry_count > 0
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died loading http://ww1.thomascook.com"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

# Click search button
begin
  url = driver.current_url
  Searchbutton = driver.find_element(:xpath, "//button[@class='btn btn-primary searchPanel-commandBtn searchPanel-searchBtn js-btn-search']")
  Searchbutton.click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

# Click the first details button
begin
  url = driver.current_url
  Detailsbutton = driver.find_element(:xpath, "//a[@class='btn btn-primary btn-heavy btn-block cta-arrow-right src-srpResult-ctaButton']")
  Detailsbutton.click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

#Click Book now
begin
  url = driver.current_url
  Bookbutton = driver.find_element(:xpath, "//a[@class='priceTicket-bookButton btn btn-primary cta-arrow-right btn-heavy']")
  Bookbutton.click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

# Continue to signing forms
begin
  url = driver.current_url
  Continuebutton = driver.find_element(:xpath, "//a[@class='btn btn-primary cta-arrow-right pull-right']")
  Continuebutton.location_once_scrolled_into_view
  Continuebutton.click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

# Insert postcode and look for the location to appear
begin
  url = driver.current_url
  Postcode = driver.find_element(:name, "addressFormBean.postCode")
  Postcode.location_once_scrolled_into_view
  Postcode.send_keys "GU249DQ"
  main_window = driver.window_handle
  Findbutton = driver.find_element(:xpath, "//a[@class='btn btn-default']")
  Findbutton.location_once_scrolled_into_view
  Findbutton.click
  sleep 5
  driver.switch_to.window(main_window)

  Streetname = driver.find_element(:name, "addressFormBean.streetAddress")
  Streetname.location_once_scrolled_into_view
  unless Streetname.attribute('value').include? "PILGRIMS WAY"
    fail "Street box does not contain PILGRIMS WAY"
  end

  City = driver.find_element(:name, "addressFormBean.city")
  City.location_once_scrolled_into_view
  unless City.attribute('value').include? "WOKING"
    fail "City box does not contain WOKING"
  end

  CountryDropdown = driver.find_element(:name, "addressFormBean.country")
  CountryDropdown.location_once_scrolled_into_view
  Option = CountryDropdown.find_element(tag_name: "option")
  unless Option.attribute('value').include? "UK"
    fail "Country box does not contain United Kingdom"
  end

rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

puts "UK v1 is well!"

teardown(headless,driver,screenfile,vidfile,retval)
