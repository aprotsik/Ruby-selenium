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

  driver.navigate.to "http://neckermann.nl/vlieg-vakanties.aspx"
  #driver.navigate.to "http://ww2.neckermann.nl/vliegvakanties"
  url = driver.current_url

if url.include? "ww2"
  then

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
  sleep 2
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
  #sleep 1
  #driver.find_element(:id => "title").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "title")).select_by :text, "Meneer"
  driver.find_element(:id, "name").send_keys "Luke"
  driver.find_element(:id, "surname").send_keys "Skywalker"
  driver.find_element(:id, "email").send_keys "jediknight@gmail.com"
  driver.find_element(:id, "leadPassengerConfirmEmail").send_keys "jediknight@gmail.com"
  driver.find_element(:id, "street").send_keys "Rokin"
  driver.find_element(:id, "houseNumber").send_keys "1"
  driver.find_element(:id, "postCode").send_keys "1012 KT"
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

else

# Click search button
begin
  url = driver.current_url
  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  wait.until { driver.find_element(:id, "st_popup_acceptButton").click }
  #wait.until { driver.find_element(:xpath, "//a[@class='goBack close grey']").click }
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "qsmNumberOfAdults_room_1")).select_by :value, "2"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "qsmNumberOfChildren_room_1")).select_by :value, "0"
  driver.find_element(:id, "QsmListerOrFullTextSearch_/sitecore/content/eComHome/Configuration/Common/Components/Solr/EQsmHomeFlight_label").click
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

# Click the first details button
begin
  url = driver.current_url
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
      driver.save_screenshot("neckermann.nl/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

url = driver.current_url
if url.include? "NadDetailPage"

#Click Book now
begin
  #url = driver.current_url
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
      driver.save_screenshot("neckermann.nl/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end

else
#Click another Book now
begin
  #url = driver.current_url
  driver.find_element(:id, "calcbuttonspan_extra").click
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
      driver.save_screenshot("neckermann.nl/#{screen_count}_#{screenfile}")
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
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_gender")).select_by :value, "Male"
  driver.find_element(:id, "TravellerDetails_1_firstName").send_keys "Luke"
  driver.find_element(:id, "TravellerDetails_1_lastName").send_keys "Skywalker"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_days")).select_by :text, "13"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_months")).select_by :text, "juni"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_years")).select_by :text, "1990"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_gender")).select_by :text, "Vrouw"
  driver.find_element(:id, "TravellerDetails_2_firstName").send_keys "Mara"
  driver.find_element(:id, "TravellerDetails_2_lastName").send_keys "Skywalker"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_days")).select_by :text, "25"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_months")).select_by :text, "apr"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_years")).select_by :text, "1992"
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
      driver.save_screenshot("neckermann.nl/#{screen_count}_#{screenfile}")
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
      driver.save_screenshot("neckermann.nl/#{screen_count}_#{screenfile}")
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
      driver.save_screenshot("neckermann.nl/#{screen_count}_#{screenfile}")
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
      driver.save_screenshot("neckermann.nl/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end
end

puts "neckermann.nl is well!"

teardown(driver,screenfile,retval)
