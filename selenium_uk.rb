#!/usr/bin/env ruby

require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
site_url = "http://www.thomascook.com"

msg = "UK is well !"
retval = 0

driver.manage.window.maximize

wait =  Selenium::WebDriver::Wait.new(:timeout => 30)

# Access thomascook.com
begin 
  driver.manage.timeouts.implicit_wait = 30
  driver.navigate.to site_url
rescue
  driver.save_screenshot("./#{Time.now.strftime("Failure__%d.%m.%Y__%H:%M:%S")}.png")
  msg = "Error loading #{login_url}"
  puts msg	
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
  msg = "Error clicking search"
  puts msg	
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
  msg = "Error clicking details"
  puts msg	
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
  msg = "Error clicking book now"
  puts msg
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
  msg = "Error proceeding to forms"	
  puts msg
  driver.quit
  exit 5
end

puts msg

driver.close
driver.quit
exit retval