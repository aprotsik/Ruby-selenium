#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'fileutils'
require 'io/console'
require './scripts/functions.rb'

sitename = "thomascook.de"
puts "Testing #{sitename}"
start_webdriver(sitename)

# Access www.thomascook.de
@driver.navigate.to "http://www.thomascook.de"

# Click search button
begin
  puts "Performing search..."
  url = @driver.current_url
  @driver.find_element(:xpath, "//span[@class='letsgo icon-uniE604']").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

# Click wahlen
begin
  puts "Choosing destination..."
  url = @driver.current_url
  @driver.find_element(:id, "0_dest").click
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
  @driver.find_element(:xpath, "//p[@class='brand-arrow-btn-md-alt mg-tb6 mg-l6']").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

#Click Strange pre-book button
begin
  puts "Proceeding to checkout..."
  url = @driver.current_url
  @driver.find_element(:xpath, "//a[@class='btn btn-primary mg-t2 pull-right pd-b2 tt-ucase']").click
  @driver.find_element(:xpath, "//a[@class='brand-arrow-btn-md mg-t2']").click
rescue => exception
  exception_handler(exception,sitename)
  if @retry_flag == true
    retry
  end
end

puts "thomascook.de is well!"

stop_webdriver(@driver,@screenfile,@retval,sitename)