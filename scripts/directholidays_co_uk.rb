#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'fileutils'
require 'io/console'
require './scripts/functions.rb'

sitename = "directholidays.co.uk"
puts "Testing #{sitename}"
start_webdriver(sitename)

# Access directholidays.co.uk

@driver.navigate.to "http://www.directholidays.co.uk"
url = @driver.current_url

begin
  puts "Performing search..."
  url = @driver.current_url
  @driver.find_element(:class, "custom-select-label-container").click
  @driver.find_element(:xpath, "//li[contains(., 'London - All Airports - (LON)')]").click
  
  @driver.find_element(:name, "checkInDate").click
  2.times do
  @driver.find_element(:xpath, "//a[@title='Next']").click
  end

  @driver.find_element(:xpath, "//a[@class='ui-state-default']").click

  i = 1 
    begin
      @driver.find_element(:xpath, "//div[@class='custom-select airportSelect']").click
      text = @driver.find_element(:xpath, "//li[@class='custom-select-option optgroup-option'][#{i}]").text.scan(/[A-Z]{3}/).first
      @driver.find_element(:xpath, "//li[@class='custom-select-option optgroup-option'][#{i}]").click
      @driver.find_element(:name, "searchButton").click
      wait = Selenium::WebDriver::Wait.new(:timeout => 120)
      wait.until { @driver.current_url.include? "results?arrival_point=#{text}" }
      url = @driver.current_url
      i+=1
    end until url =~ /(.*)\/results(.*)/

rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

# Click Details
begin
  puts "Choosing search result..."
  url = @driver.current_url
  @driver.find_element(:name, "conflictResolvePanel:placeHolder:form:costButton").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

# Continue to signing forms
begin
  puts "Proceeding to checkout..."
  url = @driver.current_url
  @driver.find_element(:name, "checkoutFlow:next").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

puts "directholidays.co.uk is well!"

stop_webdriver(@driver,@screenfile,@retval,sitename)