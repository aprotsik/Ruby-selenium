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

FileUtils.mkdir_p 'neckermann.nl'
FileUtils.rm_rf(Dir.glob('neckermann.nl/*'))

driver.manage.window.maximize
driver.manage.timeouts.page_load = 30
driver.manage.timeouts.implicit_wait = 30 

def teardown(driver,screenfile,retval)
  sleep 5
  driver.save_screenshot("neckermann.nl/#{screenfile}")
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



# Access neckermann.nl

  #driver.navigate.to "http://neckermann.nl/vlieg-vakanties.aspx"
  driver.navigate.to "http://ww2.neckermann.nl/vliegvakanties"
  url = driver.current_url

  begin
  url = driver.current_url
  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  wait.until { driver.find_element(:id, "st_popup_acceptButton").click }
  driver.find_element(:id, "when").click
  2.times do
  driver.find_element(:xpath, "//a[@data-handler='next']").click
  end
  driver.find_element(:xpath, "//a[@class='ui-state-default']").click
  driver.find_element(:id, "SearchbarForm-submitBtn").click
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
      driver.save_screenshot("neckermann.nl/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

begin
  url = driver.current_url
  driver.find_element(:xpath, "//a[@class='btn btn-success detailsBtn']").click
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
      driver.save_screenshot("thomascook.com/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

begin
  url = driver.current_url
  driver.find_element(:id, "bookNow").click
  #driver.find_element(:id, "submit-extras").click
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
      driver.save_screenshot("thomascook.com/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

begin
  url = driver.current_url
  sleep 5
  driver.find_element(:id, "submit-extras").location_once_scrolled_into_view
  driver.find_element(:id, "submit-extras").click
rescue => exception
  puts "#{exception}"
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
      driver.save_screenshot("thomascook.com/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

begin
  url = driver.current_url
  sleep 5
  #driver.find_element(:id => "title").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "title")).select_by :text, "Meneer"
  driver.find_element(:id, "name").send_keys "Luke"
  driver.find_element(:id, "surname").send_keys "Skywalker"
  driver.find_element(:id, "email").send_keys "jediknight@gmail.com"
  driver.find_element(:id, "leadPassengerConfirmEmail").send_keys "jediknight@gmail.com"
  driver.find_element(:id, "street").send_keys "Rokin"
  driver.find_element(:id, "houseNumber").send_keys "1"
  driver.find_element(:id, "postCode").send_keys "1012KT"
  driver.find_element(:id, "city").send_keys "Amsterdam"
  
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "day")).select_by :text, "13"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "month")).select_by :text, "Juni"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "year")).select_by :text, "1990"
  driver.find_element(:id, "contactNumber").send_keys "+31 30 2357822"
  

  driver.find_element(:id, "emergencyName").send_keys "Obiwan"
  driver.find_element(:id, "emergencyPhone").send_keys "+31 30 2357822"

  driver.find_element(:xpath, "//a[@class='btn btn-success noArrow pax-confirm']").click


  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "title2Room1")).select_by :text, "Mevrouw"
  driver.find_element(:id, "name2Room1").send_keys "Mara"
  driver.find_element(:id, "surname2Room1").send_keys "Skywalker"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "day2Room1")).select_by :text, "25"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "month2Room1")).select_by :text, "April"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "year2Room1")).select_by :text, "1992"
  driver.find_element(:id, "paxSubmit").click


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
      driver.save_screenshot("thomascook.com/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

puts "ww2.neckermann.nl is well!"

teardown(driver,screenfile,retval)
