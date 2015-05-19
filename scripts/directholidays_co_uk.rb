#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'fileutils'
require 'io/console'

client = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 300
driver = Selenium::WebDriver.for(:firefox, :http_client => client) 
retval = 0
screenfile = "#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
ret_ind = true
screen_count = 1

FileUtils.mkdir_p 'directholidays.co.uk'
FileUtils.rm_rf(Dir.glob('directholidays.co.uk/*'))

driver.manage.window.maximize
driver.manage.timeouts.page_load = 30
driver.manage.timeouts.implicit_wait = 30 

def teardown(driver,screenfile,retval)
  sleep 5
  driver.save_screenshot("directholidays.co.uk/#{screenfile}")
  driver.quit
  exit retval  
end

def read_char
  STDIN.echo = false
  STDIN.raw!
 
  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.cooked!
  return input
end



# Access directholidays.co.uk

  driver.navigate.to "http://www.directholidays.co.uk"

# Click search button
begin
  url = driver.current_url
  driver.find_element(:id, "bBookNow").click
rescue => exception
  ret_ind = true
  while ret_ind == true do 
  puts "Exceptional situation occurred. What do you want to do? Press 'r' to retry, do the step manually and then press 'n' to move to the next step, press 's' to capture screenshot, press 't' to terminate the script."
   c = read_char
  case c
    when "r"
      puts "Retrying..."
      driver.navigate.refresh
      retry
    when "n"
      puts "Proceeding to the next step..."
      ret_ind = false
    when "t"
      puts "Executing teardown..."
      retval = 5
      teardown(driver,screenfile,retval)
    when "s"
      puts "Capturing screenshot..."
      driver.save_screenshot("directholidays.co.uk/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

# Click the first details button
begin
  url = driver.current_url
  driver.find_element(:xpath, "//a[@onclick='showAccomodationWaitPage(event)']").click
rescue => exception
  ret_ind = true
  while ret_ind == true do 
  puts "Exceptional situation occurred. What do you want to do? Press 'r' to retry, do the step manually and then press 'n' to move to the next step, press 's' to capture screenshot, press 't' to terminate the script."
   c = read_char
  case c
    when "r"
      puts "Retrying..."
      driver.navigate.refresh
      retry
    when "n"
      puts "Proceeding to the next step..."
      ret_ind = false
    when "t"
      puts "Executing teardown..."
      retval = 5
      teardown(driver,screenfile,retval)
    when "s"
      puts "Capturing screenshot..."
      driver.save_screenshot("directholidays.co.uk/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

#Click Book now
begin
  url = driver.current_url
  driver.find_element(:id, "bookNowLink_1").click
rescue => exception
  ret_ind = true
  while ret_ind == true do 
  puts "Exceptional situation occurred. What do you want to do? Press 'r' to retry, do the step manually and then press 'n' to move to the next step, press 's' to capture screenshot, press 't' to terminate the script."
   c = read_char
  case c
    when "r"
      puts "Retrying..."
      driver.navigate.refresh
      retry
    when "n"
      puts "Proceeding to the next step..."
      ret_ind = false
    when "t"
      puts "Executing teardown..."
      retval = 5
      teardown(driver,screenfile,retval)
    when "s"
      puts "Capturing screenshot..."
      driver.save_screenshot("directholidays.co.uk/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

# Continue to signing forms
begin
  url = driver.current_url
  driver.find_element(:xpath, "//a[@class='btn nextBtn btn-sec']").click
rescue => exception
  ret_ind = true
  while ret_ind == true do 
  puts "Exceptional situation occurred. What do you want to do? Press 'r' to retry, do the step manually and then press 'n' to move to the next step, press 's' to capture screenshot, press 't' to terminate the script."
   c = read_char
  case c
    when "r"
      puts "Retrying..."
      driver.navigate.refresh
      retry
    when "n"
      puts "Proceeding to the next step..."
      ret_ind = false
    when "t"
      puts "Executing teardown..."
      retval = 5
      teardown(driver,screenfile,retval)
    when "s"
      puts "Capturing screenshot..."
      driver.save_screenshot("directholidays.co.uk/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

# Fill the passenger details
begin
  url = driver.current_url
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "title_0")).select_by :text, "Mr"
  driver.find_element(:id, "firstName_0").send_keys "Luke"
  driver.find_element(:id, "lastName_0").send_keys "Skywalker"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "passengerFormBean.passengerListForm0.dayOB")).select_by :text, "13"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "passengerFormBean.passengerListForm0.monthOB")).select_by :text, "June"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "passengerFormBean.passengerListForm0.yearOB")).select_by :text, "1990"

  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "title_1")).select_by :text, "Mrs"
  driver.find_element(:id, "firstName_1").send_keys "Mara"
  driver.find_element(:id, "lastName_1").send_keys "Skywalker"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "passengerFormBean.passengerListForm1.dayOB")).select_by :text, "25"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "passengerFormBean.passengerListForm1.monthOB")).select_by :text, "April"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "passengerFormBean.passengerListForm1.yearOB")).select_by :text, "1992"

  Postcode = driver.find_element(:id, "postcode")
  Postcode.location_once_scrolled_into_view
  Postcode.send_keys "GU24 9DQ"

  driver.find_element(:id, "findAddressButton").click
  sleep 5

  driver.find_element(:id, "contactNumber").send_keys "02072194272"
  driver.find_element(:id, "email").send_keys "jediknight@gmail.com"
  driver.find_element(:id, "confirmEmail").send_keys "jediknight@gmail.com"
  

    Street = driver.find_element(:id, "streetAddress")
  Street.location_once_scrolled_into_view
  unless Street.attribute('value').include? "PILGRIMS WAY"
    fail "Street box does not contain WOKING"
  end

  City = driver.find_element(:id, "townCity")
  City.location_once_scrolled_into_view
  unless City.attribute('value').include? "WOKING"
    fail "City box does not contain WOKING"
  end

  CountryDropdown = driver.find_element(:id, "countrySelect")
  CountryDropdown.location_once_scrolled_into_view
  Option = CountryDropdown.find_element(tag_name: "option")
  unless Option.attribute('value').include? "UK"
    fail "Country box does not contain United Kingdom"
  end

  driver.find_element(:id, "houseNumber").send_keys "1"
  driver.find_element(:xpath, "//input[@value='CONTINUE']").click
  
rescue => exception
  ret_ind = true
  while ret_ind == true do 
  puts "Exceptional situation occurred. What do you want to do? Press 'r' to retry, do the step manually and then press 'n' to move to the next step, press 's' to capture screenshot, press 't' to terminate the script."
   c = read_char
  case c
    when "r"
      puts "Retrying..."
      driver.navigate.refresh
      retry
    when "n"
      puts "Proceeding to the next step..."
      ret_ind = false
    when "t"
      puts "Executing teardown..."
      retval = 5
      teardown(driver,screenfile,retval)
    when "s"
      puts "Capturing screenshot..."
      driver.save_screenshot("directholidays.co.uk/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

puts "directholidays.co.uk is well!"

teardown(driver,screenfile,retval)
