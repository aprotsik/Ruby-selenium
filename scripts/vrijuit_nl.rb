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

FileUtils.mkdir_p 'vrijuit.nl'
FileUtils.rm_rf(Dir.glob('vrijuit.nl/*'))

driver.manage.window.maximize
driver.manage.timeouts.page_load = 30
driver.manage.timeouts.implicit_wait = 30 

def teardown(driver,screenfile,retval)
  sleep 5
  driver.save_screenshot("vrijuit.nl/#{screenfile}")
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



# Access vrijuit.nl

  driver.navigate.to "http://vrijuit.nl"

# Click search button
begin
  url = driver.current_url
  #driver.find_element(:id, "st_popup_acceptButton").click
  driver.find_element(:id, "QsmListerOrFullTextSearch_/sitecore/content/eComHome/Configuration/Channels/Main/Pages/Home/QSM_label").click
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
      driver.save_screenshot("vrijuit.nl/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

# Click pop-up
begin
  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  wait.until { driver.find_element(:id, "st_popup_acceptButton").click }
rescue => exception
end

# Click the first details button
begin
  driver.find_element(:xpath, "//span[@class='label']").click
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
      driver.save_screenshot("vrijuit.nl/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

url = driver.current_url
#Click Book now
if url.include? "NadDetailPage"

begin
  driver.find_element(:id, "#tabBar-Prices2").click
  driver.find_element(:xpath, "(//a[contains(@data-room, '1')])").click
  driver.find_element(:id, "priceTicket-submitButton").click
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
      driver.save_screenshot("vrijuit.nl/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

else

begin
  driver.find_element(:id, "calcbuttonspan_calctransport").click
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
      driver.save_screenshot("vrijuit.nl/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

end

# Fill the passenger details
begin
  url = driver.current_url
  driver.find_element(:id => "TravellerDetails_1_gender").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_gender")).select_by :value, "Male"
  driver.find_element(:id, "TravellerDetails_1_firstName").send_keys "Luke"
  driver.find_element(:id, "TravellerDetails_1_lastName").send_keys "Skywalker"
  driver.find_element(:id => "TravellerDetails_1_days").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_days")).select_by :text, "13"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_months")).select_by :text, "juni"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_years")).select_by :text, "1990"
  driver.find_element(:id => "TravellerDetails_2_gender").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_gender")).select_by :value, "Female"
  driver.find_element(:id, "TravellerDetails_2_firstName").send_keys "Mara"
  driver.find_element(:id, "TravellerDetails_2_lastName").send_keys "Skywalker"
  driver.find_element(:id => "TravellerDetails_2_days").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_days")).select_by :text, "25"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_months")).select_by :text, "apr"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_years")).select_by :text, "1992"
  
  Gender = driver.find_element(:id, "TravellerDetails_1_gender")
  unless Gender.attribute('value').include? "Male"
    fail "Some values are missing!"
  end

  Gender1 = driver.find_element(:id, "TravellerDetails_2_gender")
  unless Gender1.attribute('value').include? "Female"
    fail "Some values are missing!"
  end

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
      driver.save_screenshot("vrijuit.nl/#{screen_count}_#{screenfile}")
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
      driver.save_screenshot("vrijuit.nl/#{screen_count}_#{screenfile}")
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
  driver.find_element(:id, "TravellerDetails_1_phoneNumber").send_keys "+31 30 2357822"
  driver.find_element(:id, "TravellerDetails_1_email1").send_keys "luke.skywalker@gmail.com"
  driver.find_element(:id, "ConfirmEmailAddress").send_keys "luke.skywalker@gmail.com"
  driver.find_element(:id, "emergencyContact").send_keys "Obiwan"
  driver.find_element(:id, "emergencyPhoneNumber").send_keys "+31 30 2357822"
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
      driver.save_screenshot("vrijuit.nl/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

#Click Agree to pay
begin
  url = driver.current_url
  driver.find_element(:id, "NlPayAgreement").click
  driver.find_element(:id, "defaultPaymentAgreed_label").click
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
      driver.save_screenshot("vrijuit.nl/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

puts "vrijuit.nl is well!"

teardown(driver,screenfile,retval)
