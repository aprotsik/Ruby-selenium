#!/usr/bin/env ruby

require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
site_url = "http://www.thomascook.com"

msg = 
retval = 0

driver.manage.window.maximize

wait =  Selenium::WebDriver::Wait.new(:timeout => 30)

# Access thomascook.com
begin 
  driver.manage.timeouts.implicit_wait = 30
  driver.navigate.to site_url
rescue
  driver.save_screenshot("./#{Time.now.strftime("Failure__%d.%m.%Y__%H:%M:%S")}.png")
  puts "Error loading #{login_url}"	
  driver.quit
  exit 5
end

# Click search button
begin
  wait.until { driver.find_element(:xpath, "//button[@class='btn btn-primary searchPanel-commandBtn searchPanel-searchBtn js-btn-search']").displayed? }
  Searchbutton = driver.find_element(:xpath, "//button[@class='btn btn-primary searchPanel-commandBtn searchPanel-searchBtn js-btn-search']")
  Searchbutton.click
rescue
  driver.save_screenshot("./#{Time.now.strftime("Failure__%d.%m.%Y__%H:%M:%S")}.png")
  puts "Error clicking search"
  driver.quit
  exit 5
end

# Click the first details button
begin
  wait.until { driver.find_element(:xpath, "//a[@class='btn btn-primary btn-heavy btn-block cta-arrow-right src-srpResult-ctaButton']").displayed? }
  Detailsbutton = driver.find_element(:xpath, "//a[@class='btn btn-primary btn-heavy btn-block cta-arrow-right src-srpResult-ctaButton']")
  Detailsbutton.click
rescue
  driver.save_screenshot("./#{Time.now.strftime("Failure__%d.%m.%Y__%H:%M:%S")}.png")
  puts "Error clicking details"	
  driver.quit
  exit 5
end

#Click Book now
begin
  wait.until { driver.find_element(:xpath, "//a[@class='priceTicket-bookButton btn btn-primary cta-arrow-right btn-heavy']").displayed? }
  Bookbutton = driver.find_element(:xpath, "//a[@class='priceTicket-bookButton btn btn-primary cta-arrow-right btn-heavy']")
  Bookbutton.click
rescue
  driver.save_screenshot("./#{Time.now.strftime("Failure__%d.%m.%Y__%H:%M:%S")}.png")	
  puts "Error clicking book now"
  driver.quit
  exit 5
end

# Continue to signing forms
begin
  wait.until { driver.find_element(:xpath, "//a[@class='btn btn-primary cta-arrow-right pull-right']").displayed? }	
  Continuebutton = driver.find_element(:xpath, "//a[@class='btn btn-primary cta-arrow-right pull-right']")
  Continuebutton.location_once_scrolled_into_view
  Continuebutton.click
  driver.save_screenshot("./#{Time.now.strftime("Success__%d.%m.%Y__%H:%M:%S")}.png")
rescue
  driver.save_screenshot("./#{Time.now.strftime("Failure__%d.%m.%Y__%H:%M:%S")}.png")
  puts "Error proceeding to forms"	
  driver.quit
  exit 5
end

puts "UK is well!"

driver.close
driver.quit
exit retval