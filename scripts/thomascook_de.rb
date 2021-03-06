#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'fileutils'

client = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 300
driver = Selenium::WebDriver.for(:firefox, :http_client => client) 
retval = 0
screenfile = "#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
retry_count = 5

FileUtils.mkdir_p 'thomascook.de'
FileUtils.rm_rf(Dir.glob('thomascook.de/*'))

driver.manage.window.maximize
driver.manage.timeouts.page_load = 30
driver.manage.timeouts.implicit_wait = 30 

def teardown(driver,screenfile,retval)
  driver.save_screenshot("thomascook.de/#{screenfile}")
  driver.quit
  exit retval  
end



# Access www.thomascook.de
begin
  driver.navigate.to "http://www.thomascook.de"
rescue => exception
  retry_count -= 1
  if retry_count > 0
    retry
  else
    retval = 5
    puts exception.backtrace
    puts "Died loading http://http://www.thomascook.de"
    teardown(driver,screenfile,retval)
  end
ensure
  retry_count = 5
end

# Click search button
begin
  url = driver.current_url
  driver.find_element(:xpath, "//span[@class='letsgo icon-uniE604']").click
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

# Click wahlen
begin
  url = driver.current_url
  driver.find_element(:id, "0_dest").click
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
  driver.find_element(:xpath, "//p[@class='brand-arrow-btn-md-alt mg-tb6 mg-l6']").click
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

#Click Strange pre-book button
begin
  url = driver.current_url
  driver.find_element(:id, "PO_0").click
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
  driver.find_element(:id, "mohit0").click
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

puts "thomascook.de is well!"

teardown(driver,screenfile,retval)
