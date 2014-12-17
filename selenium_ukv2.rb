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
driver.manage.timeouts.page_load = 60
driver.manage.timeouts.implicit_wait = 60 

def teardown(headless,driver,screenfile,vidfile,retval)
  driver.save_screenshot("mail/#{screenfile}")
  #headless.video.stop_and_save("#{vidfile}")
  #FileUtils.cp("#{screenfile}", "mail")
  #FileUtils.cp("#{vidfile}", "mail")
  driver.quit
  headless.destroy
  exit retval  
end



# Access thomascook.com
begin
  driver.navigate.to "http://ww2.thomascook.com"
rescue => exception
  retry_count -= 1
  if retry_count > 0
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died loading http://ww2.thomascook.com"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

# Click search button
begin
  url = driver.current_url
  Locationbox = driver.find_element(:id, "goingTo")
  Searchbutton = driver.find_element(:id, "searchBtn")
  Locationbox.send_keys "Spain"
  sleep 5
  Locationbox.clear
  driver.save_screenshot("mail/Search_#{screenfile}")
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
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.png"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

# Click the first details button
begin
  url = driver.current_url
  Detailsbutton = driver.find_element(:xpath, "//button[@class='btn btn-success detailsBtn ng-binding']")
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
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.png"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

#Click Book now
begin
  url = driver.current_url
  Bookbutton = driver.find_element(:id, "bookNow")
  Bookbutton.click
  Extras = driver.find_element(:id, "submit-extras")
  Extras.click 
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.png"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

# Continue to signing forms
begin
  url = driver.current_url
  Continuebutton = driver.find_element(:id, "submit-extras")
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
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.png"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

# Fill the passenger details
begin
  url = driver.current_url
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "title")).select_by :text, "Mr"
  driver.find_element(:id, "name").send_keys "Luke"
  driver.find_element(:id, "surname").send_keys "Skywalker"
  driver.find_element(:id, "email").send_keys "jediknight@gmail.com"
  driver.find_element(:id, "leadPassengerConfirmEmail").send_keys "jediknight@gmail.com"
  Postcode = driver.find_element(:id, "postCode")
  Postcode.location_once_scrolled_into_view
  Postcode.send_keys "GU249DQ"
  Findbutton = driver.find_element(:xpath, "//a[@class='btn btn-default get-address']")
  Findbutton.location_once_scrolled_into_view
  Findbutton.click
  sleep 5
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "addressSelect")).select_by :text, "1 PILGRIMS WAY"

  City = driver.find_element(:id, "city")
  City.location_once_scrolled_into_view
  unless City.attribute('value').include? "WOKING"
    fail "City box does not contain WOKING"
  end

  CountryDropdown = driver.find_element(:id, "country")
  CountryDropdown.location_once_scrolled_into_view
  Option = CountryDropdown.find_element(tag_name: "option")
  unless Option.attribute('value').include? "UK"
    fail "Country box does not contain United Kingdom"
  end

  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "day")).select_by :text, "13"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "month")).select_by :text, "June"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "year")).select_by :text, "1990"
  driver.find_element(:id, "contactNumber").send_keys "020 7219 4272"
  Confirmbutton = driver.find_element(:xpath, "//a[@class='btn btn-success noArrow pax-confirm ng-binding']")
  Confirmbutton.click

  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "title2Room1")).select_by :text, "Mrs"
  driver.find_element(:id, "name2Room1").send_keys "Mara"
  driver.find_element(:id, "surname2Room1").send_keys "Skywalker"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "day2Room1")).select_by :text, "25"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "month2Room1")).select_by :text, "April"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "year2Room1")).select_by :text, "1992"
  Confirmbuttonsecond = driver.find_element(:id, "paxSubmit")
  Confirmbuttonsecond.click

rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.png"
    teardown(headless,driver,screenfile,vidfile,retval)
  end
ensure
  retry_count = 5
end

puts "UK v2 is well!"

teardown(headless,driver,screenfile,vidfile,retval)
