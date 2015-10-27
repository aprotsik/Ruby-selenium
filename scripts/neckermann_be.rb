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

FileUtils.mkdir_p 'neckermann.be'
FileUtils.rm_rf(Dir.glob('neckermann.be/*'))

driver.manage.window.maximize
driver.manage.timeouts.page_load = 120
driver.manage.timeouts.implicit_wait = 30 

def teardown(driver,screenfile,retval)
  sleep 5
  driver.save_screenshot("neckermann.be/#{screenfile}")
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



# Access neckermann.be

  driver.navigate.to "http://www.neckermann.be/vliegvakanties"


# Click search button
begin
  url = driver.current_url
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "qsmNumberOfAdults_room_1")).select_by :value, "2"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "qsmNumberOfChildren_room_1")).select_by :value, "0"
  driver.find_element(:id, "QsmListerOrFullTextSearch_/sitecore/content/eComHome/Configuration/Common/Components/Redesign/SOLR/QSM_label").click
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
      driver.save_screenshot("neckermann.be/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

# Click the first details button
begin
  url = driver.current_url
  driver.find_element(:css, "#QsmDetailLink_1 > span.label").click
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
      driver.save_screenshot("neckermann.be/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

#Click Book now
begin
  url = driver.current_url
  driver.find_element(:id, "calcbuttonspan_calc").click
  driver.find_element(:xpath, "//span[@class='label bookNowButton']").click
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
      driver.save_screenshot("neckermann.be/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

# Fill the passenger details
begin
  url = driver.current_url
  sleep 5
  driver.find_element(:id => "TravellerDetails_1_gender").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_gender")).select_by :value, "Male"
  driver.find_element(:id, "TravellerDetails_1_firstName").send_keys "Luke"
  driver.find_element(:id, "TravellerDetails_1_lastName").send_keys "Skywalker"
  driver.find_element(:id => "TravellerDetails_1_days").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_days")).select_by :value, "13"
  driver.find_element(:id => "TravellerDetails_1_months").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_months")).select_by :value, "6"
  driver.find_element(:id => "TravellerDetails_1_years").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_years")).select_by :value, "1990"
  driver.find_element(:id => "TravellerDetails_2_gender").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_gender")).select_by :value, "Female"
  driver.find_element(:id, "TravellerDetails_2_firstName").send_keys "Mara"
  driver.find_element(:id, "TravellerDetails_2_lastName").send_keys "Skywalker"
  driver.find_element(:id => "TravellerDetails_2_days").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_days")).select_by :value, "25"
  driver.find_element(:id => "TravellerDetails_2_months").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_months")).select_by :value, "4"
  driver.find_element(:id => "TravellerDetails_2_years").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_years")).select_by :value, "1992"
  driver.find_element(:id, "foSubmit").click
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
      driver.save_screenshot("neckermann.be/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

#Click Next button
begin
  url = driver.current_url
  driver.find_element(:id, "btnNext").click
  driver.find_element(:id, "optionsandextrasInsurancePopupYesBtn").click
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
      driver.save_screenshot("neckermann.be/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

# Fill the passenger details (more)
begin
  url = driver.current_url
  driver.find_element(:id, "TravellerDetails_1_street").send_keys "Rokin"
  driver.find_element(:id, "TravellerDetails_1_houseNumber").send_keys "1"
  driver.find_element(:id, "TravellerDetails_1_zipCode").send_keys "1012 KT"
  driver.find_element(:id, "TravellerDetails_1_city").send_keys "Amsterdam"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_country")).select_by :value, "NL"
  driver.find_element(:id, "TravellerDetails_1_mobilePhoneNumber").send_keys "+31 30 2357822"
  driver.find_element(:id, "TravellerDetails_1_email1").send_keys "luke.skywalker@gmail.com"
  driver.find_element(:id, "ConfirmEmailAddress").send_keys "luke.skywalker@gmail.com"
  driver.find_element(:id, "toPaymentButton").click

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
      driver.save_screenshot("neckermann.be/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

puts "neckermann.be/vliegvakanties is well!"

teardown(driver,screenfile,retval)
