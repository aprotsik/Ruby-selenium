#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'fileutils'
require 'io/console'
require './scripts/functions.rb'

sitename = "neckermann.nl_v2"
puts "Testing #{sitename}"
start_webdriver(sitename)

# Access neckermann.nl

#@driver.navigate.to "http://neckermann.nl/vlieg-vakanties.aspx"
@driver.navigate.to "http://ww2.neckermann.nl/vliegvakanties"
url = @driver.current_url

begin
  puts "Performing search..."
  url = @driver.current_url
  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  wait.until { @driver.find_element(:id, "st_popup_acceptButton").click }
  @driver.find_element(:id, "when").click
  2.times do
  @driver.find_element(:xpath, "//a[@data-handler='next']").click
  end
  @driver.find_element(:xpath, "//a[@class='ui-state-default']").click
  @driver.find_element(:id, "SearchbarForm-submitBtn").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

begin
  puts "Choosing search result..."
  url = @driver.current_url
  @driver.find_element(:xpath, "//a[@class='btn btn-success detailsBtn']").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

begin
  puts "Booking..."
  url = @driver.current_url
  @driver.find_element(:id, "bookNow").click
  #@driver.find_element(:id, "submit-extras").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

begin
  puts "Trip customizing..."
  url = @driver.current_url
  sleep 5
  @driver.find_element(:id, "submit-extras").location_once_scrolled_into_view
  @driver.find_element(:id, "submit-extras").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

begin
  puts "Filling passenger details..."
  url = @driver.current_url
  sleep 5
  #@driver.find_element(:id => "title").click
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "title")).select_by :text, "Meneer"
  @driver.find_element(:id, "name").send_keys "Luke"
  @driver.find_element(:id, "surname").send_keys "Skywalker"
  @driver.find_element(:id, "email").send_keys "jediknight@gmail.com"
  @driver.find_element(:id, "leadPassengerConfirmEmail").send_keys "jediknight@gmail.com"
  @driver.find_element(:id, "street").send_keys "Rokin"
  @driver.find_element(:id, "houseNumber").send_keys "1"
  @driver.find_element(:id, "postCode").send_keys "1012KT"
  @driver.find_element(:id, "city").send_keys "Amsterdam"  
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "day")).select_by :text, "13"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "month")).select_by :text, "Juni"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "year")).select_by :text, "1990"
  @driver.find_element(:id, "contactNumber").send_keys "+31 30 2357822"  
  @driver.find_element(:id, "emergencyName").send_keys "Obiwan"
  @driver.find_element(:id, "emergencyPhone").send_keys "+31 30 2357822"
  @driver.find_element(:xpath, "//a[@class='btn btn-success noArrow pax-confirm']").click
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "title2Room1")).select_by :text, "Mevrouw"
  @driver.find_element(:id, "name2Room1").send_keys "Mara"
  @driver.find_element(:id, "surname2Room1").send_keys "Skywalker"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "day2Room1")).select_by :text, "25"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "month2Room1")).select_by :text, "April"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "year2Room1")).select_by :text, "1992"
  @driver.find_element(:id, "paxSubmit").click

rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

puts "ww2.neckermann.nl is well!"

stop_webdriver(@driver,@screenfile,@retval,sitename)
