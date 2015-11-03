#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'fileutils'
require 'io/console'
require './scripts/functions.rb'

sitename = "oneweb.thomascook.de"
puts "Testing #{sitename}"
start_webdriver(sitename)

# Access oneweb.thomascook.com

@driver.navigate.to "http://oneweb.thomascook.com"

# Login as guest
begin
  puts "Entering site as guest..."
  url = @driver.current_url
  @driver.find_element(:id, "testLogin").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

# Click Search
begin
  puts "Performing search..."
  url = @driver.current_url
  time = Time.now + (4*7*24*60*60)
  date = time.strftime("%d-%m-%Y")
  #@driver.find_element(:xpath, "//span[@class='ui-button-text']").click
  @driver.find_element(:id, "pkgtoDateRange").clear()
  @driver.find_element(:id, "pkgtoDateRange").send_keys "#{date}"
  @driver.find_element(:id, "pkgProductSearch").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

#Select resort
begin
  puts "Choosing search result..."
  url = @driver.current_url
  @driver.find_element(:xpath, "//a[@class='fontIcon-arrow-right']").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

# Click checkout
begin
  puts "Proceeding to checkout..."
  url = @driver.current_url
  @driver.find_element(:xpath, "//a[@class='book']").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

# Accept terms & Click continue booking
begin
  puts "Accepting terms..."
  url = @driver.current_url
  #@driver.find_element(:id, "errataTerms").click
  #@driver.find_element(:id, "acceptErata").click
  @driver.find_element(:id, "continueButton").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

puts "oneweb.thomascook.com is well!"

stop_webdriver(@driver,@screenfile,@retval,sitename)