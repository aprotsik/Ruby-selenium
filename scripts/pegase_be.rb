#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'fileutils'
require 'io/console'
require './scripts/functions.rb'

sitename = "pegase.be"
puts "Testing #{sitename}"
start_webdriver(sitename)

# Access neckermann.be

@driver.navigate.to "https://www.pegase.be/"

# Click search button
begin
  puts "Performing search..."
  url = @driver.current_url
 #Children 
 #Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "qsmNumberOfAdults_room_1")).select_by :value, "2"
#Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "qsmNumberOfChildren_room_1")).select_by :value, "0"
  @driver.find_element(:id, "QsmListerOrFullTextSearch_/sitecore/content/eComHome/Configuration/common/Components/ShopPegase/QSM/VelocityQsmGeneral_label").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

# Click the first details button
begin
  puts "Choosing search result..."
  url = @driver.current_url
  @driver.find_element(:id, "QsmDetailLink_1").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

#Click Book now
begin
  puts "Booking..."
  url = @driver.current_url
  @driver.find_element(:id, "calcbuttonspan").click
  @driver.find_element(:xpath, "//span[@class='label bookNowButton']").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

# Fill the passenger details
begin
  puts "Filling passenger details..."
  url = @driver.current_url
  sleep 5
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "TravellerDetails_1_gender")).select_by :value, "Male"
  @driver.find_element(:id, "TravellerDetails_1_firstName").send_keys "Luke"
  @driver.find_element(:id, "TravellerDetails_1_lastName").send_keys "Skywalker"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "TravellerDetails_1_days")).select_by :value, "13"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "TravellerDetails_1_months")).select_by :value, "6"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "TravellerDetails_1_years")).select_by :value, "1990"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "TravellerDetails_2_gender")).select_by :value, "Female"
  @driver.find_element(:id, "TravellerDetails_2_firstName").send_keys "Mara"
  @driver.find_element(:id, "TravellerDetails_2_lastName").send_keys "Skywalker"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "TravellerDetails_2_days")).select_by :value, "25"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "TravellerDetails_2_months")).select_by :value, "4"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "TravellerDetails_2_years")).select_by :value, "1992"
  @driver.find_element(:id, "foSubmit").click
  
  if @driver.page_source.include? "Remplissez les champs obligatoires."
    fail "There are some empty fields!"
  end

rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end


#Click Next button
begin
  puts "Some tour information..."
  url = @driver.current_url
  @driver.find_element(:id, "btnNext").click
  #@driver.find_element(:id, "optionsandextrasInsurancePopupYesBtn").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

# Fill the passenger details (more)
begin
  puts "More passenger details..."
  url = @driver.current_url
  @driver.find_element(:id, "TravellerDetails_1_street").send_keys "Rokin"
  @driver.find_element(:id, "TravellerDetails_1_houseNumber").send_keys "1"
  @driver.find_element(:id, "TravellerDetails_1_zipCode").send_keys "1012 KT"
  @driver.find_element(:id, "TravellerDetails_1_city").send_keys "Amsterdam"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "TravellerDetails_1_country")).select_by :value, "NL"
  @driver.find_element(:id, "TravellerDetails_1_mobilePhoneNumber").send_keys "+31 30 2357822"
  @driver.find_element(:id, "TravellerDetails_1_email1").send_keys "luke.skywalker@gmail.com"
  @driver.find_element(:id, "ConfirmEmailAddress").send_keys "luke.skywalker@gmail.com"
  @driver.find_element(:id, "toPaymentButton").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

puts "pegase.be is well!"

stop_webdriver(@driver,@screenfile,@retval,sitename)