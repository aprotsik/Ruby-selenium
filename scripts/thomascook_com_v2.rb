#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'fileutils'

client = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 300
driver = Selenium::WebDriver.for(:firefox, :http_client => client) 
retval = 0
screenfile = "#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
retry_count = 5

FileUtils.mkdir_p 'thomascook.com_v2'
FileUtils.rm_rf(Dir.glob('thomascook.com_v2/*'))

driver.manage.window.maximize
driver.manage.timeouts.page_load = 30
driver.manage.timeouts.implicit_wait = 30 

def teardown(driver,screenfile,retval)
  driver.save_screenshot("thomascook.com_v2/#{screenfile}")
  driver.quit
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
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

# Click search button
begin
  url = driver.current_url
  driver.find_element(:id, "searchBtn").click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

# Click the first details button
begin
  url = driver.current_url
  driver.find_element(:xpath, "//button[@class='btn btn-success detailsBtn ng-binding']").click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

#Click Book now
begin
  url = driver.current_url
  driver.find_element(:id, "bookNow").click
  driver.find_element(:id, "submit-extras").click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

# Continue to signing forms
begin
  url = driver.current_url
  sleep 5
  driver.find_element(:id, "submit-extras").location_once_scrolled_into_view
  driver.find_element(:id, "submit-extras").click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

# Fill the passenger details
begin
  url = driver.current_url
  #sleep 1
  #driver.find_element(:id => "title").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "title")).select_by :text, "Mr"
  driver.find_element(:id, "name").send_keys "Luke"
  driver.find_element(:id, "surname").send_keys "Skywalker"
  driver.find_element(:id, "email").send_keys "jediknight@gmail.com"
  driver.find_element(:id, "leadPassengerConfirmEmail").send_keys "jediknight@gmail.com"
  Postcode = driver.find_element(:id, "postCode")
  Postcode.location_once_scrolled_into_view
  Postcode.send_keys "E7 9AL"
  driver.find_element(:xpath, "//a[@class='btn btn-default get-address']").click
  sleep 5
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "addressSelect")).select_by :text, "1 EARLHAM GROVE"

  City = driver.find_element(:id, "city")
  City.location_once_scrolled_into_view
  unless City.attribute('value').include? "LONDON"
    fail "City box does not contain LONDON"
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
  driver.find_element(:xpath, "//a[@class='btn btn-success noArrow pax-confirm']").click

  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "title2Room1")).select_by :text, "Mrs"
  driver.find_element(:id, "name2Room1").send_keys "Mara"
  driver.find_element(:id, "surname2Room1").send_keys "Skywalker"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "day2Room1")).select_by :text, "25"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "month2Room1")).select_by :text, "April"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "year2Room1")).select_by :text, "1992"
  driver.find_element(:id, "paxSubmit").click


rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

puts "UK v2 is well!"

teardown(driver,screenfile,retval)
