#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'headless'
require 'fileutils'
require 'net/http'

headless = Headless.new
headless.start
client = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 300
driver = Selenium::WebDriver.for(:firefox, :http_client => client) 
retval = 0
screenfile = "#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.png"

FileUtils.mkdir_p 'mail'
FileUtils.rm_rf(Dir.glob('mail/*'))

driver.manage.window.maximize
driver.manage.timeouts.page_load = 300



# Access thomascook.com
begin
  driver.navigate.to "http://www.thomascook.com"
  
rescue => exception
  puts exception.backtrace
  puts "Died loading http://www.thomascook.com"
  driver.save_screenshot("#{screenfile}")
  FileUtils.cp("#{screenfile}", "mail")
  driver.quit
  headless.destroy
  exit 5  
end

# Click search button
begin
  url = driver.current_url
  driver.manage.timeouts.implicit_wait = 300 
  Searchbutton = driver.find_element(:xpath, "//button[@class='btn btn-primary searchPanel-commandBtn searchPanel-searchBtn js-btn-search']")
  Searchbutton.click

rescue => exception
  puts exception.backtrace
  puts "Died on #{url}"
  driver.save_screenshot("#{screenfile}")
  FileUtils.cp("#{screenfile}", "mail")
  driver.quit
  headless.destroy
  exit 5  
end

# Click the first details button
begin
  url = driver.current_url
  driver.manage.timeouts.implicit_wait = 300 
  Detailsbutton = driver.find_element(:xpath, "//a[@class='btn btn-primary btn-heavy btn-block cta-arrow-right src-srpResult-ctaButton']")
  Detailsbutton.click

rescue => exception
  puts exception.backtrace
  puts "Died on #{url}" 
  driver.save_screenshot("#{screenfile}")
  FileUtils.cp("#{screenfile}", "mail")
  driver.quit
  headless.destroy
  exit 5    
end

#Click Book now
begin
  url = driver.current_url
  driver.manage.timeouts.implicit_wait = 300 
  Bookbutton = driver.find_element(:xpath, "//a[@class='priceTicket-bookButton btn btn-primary cta-arrow-right btn-heavy']")
  Bookbutton.click

rescue => exception
  puts exception.backtrace
  puts "Died on #{url}"
  driver.save_screenshot("#{screenfile}")
  FileUtils.cp("#{screenfile}", "mail")
  driver.quit
  headless.destroy
  exit 5        
end

# Continue to signing forms
begin
  url = driver.current_url
  driver.manage.timeouts.implicit_wait = 300 
  Continuebutton = driver.find_element(:xpath, "//a[@class='btn btn-primary cta-arrow-right pull-right']")
  Continuebutton.location_once_scrolled_into_view
  Continuebutton.click

rescue => exception
  puts exception.backtrace
  puts "Died on #{url}"
  driver.save_screenshot("#{screenfile}")
  FileUtils.cp("#{screenfile}", "mail")
  driver.quit
  headless.destroy
  exit 5  
end

# Insert postcode and look for the location to appear
begin
  url = driver.current_url
  driver.manage.timeouts.implicit_wait = 300 
  Postcode = driver.find_element(:name, "addressFormBean.postCode")
  Postcode.location_once_scrolled_into_view
  Postcode.send_keys "GU249DQ"
  main_window = driver.window_handle
  driver.manage.timeouts.implicit_wait = 300 
  Findbutton = driver.find_element(:xpath, "//a[@class='btn btn-default']")
  Findbutton.location_once_scrolled_into_view
  Findbutton.click
  sleep 5
  driver.switch_to.window(main_window)

  driver.manage.timeouts.implicit_wait = 300
  Streetname = driver.find_element(:name, "addressFormBean.streetAddress")
  Streetname.location_once_scrolled_into_view
  unless Streetname.attribute('value').include? "PILGRIMS WAY"
    fail "Street box does not contain PILGRIMS WAY"
  end

  driver.manage.timeouts.implicit_wait = 300
  City = driver.find_element(:name, "addressFormBean.city")
  City.location_once_scrolled_into_view
  unless City.attribute('value').include? "WOKING"
    fail "City box does not contain WOKING"
  end

  driver.manage.timeouts.implicit_wait = 300
  CountryDropdown = driver.find_element(:name, "addressFormBean.country")
  CountryDropdown.location_once_scrolled_into_view
  Option = CountryDropdown.find_element(tag_name: "option")
  unless Option.attribute('value').include? "UK"
    fail "Country box does not contain United Kingdom"
  end
  driver.save_screenshot("#{screenfile}")

rescue => exception
  puts exception.backtrace
  puts "Died on #{url}"
  driver.save_screenshot("#{screenfile}")
  FileUtils.cp("#{screenfile}", "mail")
  driver.quit
  headless.destroy
  exit 5  
end



puts "UK is well!"

driver.close
driver.quit
headless.destroy
exit retval