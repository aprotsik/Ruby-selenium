#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'fileutils'

client = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 300
driver = Selenium::WebDriver.for(:firefox, :http_client => client) 
retval = 0
screenfile = "#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
retry_count = 5

FileUtils.mkdir_p 'neckermann.be'
FileUtils.rm_rf(Dir.glob('neckermann.be/*'))

driver.manage.window.maximize
driver.manage.timeouts.page_load = 30
driver.manage.timeouts.implicit_wait = 30 

def teardown(driver,screenfile,retval)
  driver.save_screenshot("neckermann.be/#{screenfile}")
  driver.quit
  exit retval  
end



# Access neckermann.be
begin
  driver.navigate.to "http://www.neckermann.be/vliegvakanties"
rescue => exception
  retry_count -= 1
  if retry_count > 0
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died loading http://www.neckermann.be/vliegvakanties"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

# Click search button
begin
  url = driver.current_url
  driver.find_element(:id, "QsmListerOrFullTextSearch_/sitecore/content/eComHome/Configuration/Common/Components/Redesign/SOLR/QSM_label").click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

# Click the first details button
begin
  url = driver.current_url
  driver.find_element(:css, "#QsmDetailLink_1 > span.label").click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

#Click Book now
begin
  url = driver.current_url
  driver.find_element(:id, "calcbuttonspan_calc").click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

#Click another Book now
begin
  url = driver.current_url
  driver.find_element(:xpath, "//span[@class='label bookNowButton']").click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

# Fill the passenger details
begin
  url = driver.current_url
  driver.find_element(:id => "TravellerDetails_1_gender").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_gender")).select_by :value, "Male"
  driver.find_element(:id, "TravellerDetails_1_firstName").send_keys "Luke"
  driver.find_element(:id, "TravellerDetails_1_lastName").send_keys "Skywalker"
  driver.find_element(:id => "TravellerDetails_1_days").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_days")).select_by :value, "13"
  driver.find_element(:id => "TravellerDetails_1_months").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_months")).select_by :value, "6"
  driver.find_element(:id => "TravellerDetails_1_years").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_years")).select_by :value, "1990"
  driver.find_element(:id => "TravellerDetails_2_gender").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_gender")).select_by :value, "Female"
  driver.find_element(:id, "TravellerDetails_2_firstName").send_keys "Mara"
  driver.find_element(:id, "TravellerDetails_2_lastName").send_keys "Skywalker"
  driver.find_element(:id => "TravellerDetails_2_days").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_days")).select_by :value, "25"
  driver.find_element(:id => "TravellerDetails_2_months").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_months")).select_by :value, "4"
  driver.find_element(:id => "TravellerDetails_2_years").click
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_2_years")).select_by :value, "1992"
  driver.find_element(:id, "foSubmit").click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

#Click Next button
begin
  url = driver.current_url
  driver.find_element(:id, "btnNext").click
  driver.find_element(:id, "optionsandextrasInsurancePopupYesBtn").click
rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

# Fill the passenger details (more)
begin
  url = driver.current_url
  driver.find_element(:id, "TravellerDetails_1_street").send_keys "Rokin"
  driver.find_element(:id, "TravellerDetails_1_houseNumber").send_keys "1"
  driver.find_element(:id, "TravellerDetails_1_zipCode").send_keys "1012 KT"
  driver.find_element(:id, "TravellerDetails_1_city").send_keys "Amsterdam"
  Selenium::WebDriver::Support::Select.new(driver.find_element(:id => "TravellerDetails_1_country")).select_by :value, "NL"
  driver.find_element(:id, "TravellerDetails_1_mobilePhoneNumber").send_keys "+31 30 2357822"
  driver.find_element(:id, "TravellerDetails_1_email1").send_keys "luke.skywalker@gmail.com"
  driver.find_element(:id, "ConfirmEmailAddress").send_keys "luke.skywalker@gmail.com"
  driver.find_element(:id, "toPaymentButton").click

rescue => exception
  retry_count -= 1
  if retry_count > 0
    driver.navigate.refresh
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died on #{url}"
    screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

puts "neckermann.be/vliegvakanties is well!"

teardown(driver,screenfile,retval)
