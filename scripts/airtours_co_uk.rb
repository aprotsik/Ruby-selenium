#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'fileutils'
require 'io/console'

client = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 300
profile = Selenium::WebDriver::Firefox::Profile.new
profile.native_events = false
driver = Selenium::WebDriver.for(:firefox, :http_client => client, :profile => profile) 
retval = 0
screenfile = "#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
ret_ind = true
screen_count = 1

FileUtils.mkdir_p 'airtours.co.uk'
FileUtils.rm_rf(Dir.glob('airtours.co.uk/*'))

driver.manage.window.maximize
driver.manage.timeouts.page_load = 120
driver.manage.timeouts.implicit_wait = 30 

def teardown(driver,screenfile,retval)
  sleep 5
  driver.save_screenshot("airtours.co.uk/#{screenfile}")
  driver.quit
  exit retval 
end

def read_char
  STDIN.echo = false
  STDIN.raw!
 
  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.cooked!
  return input
end


# Access airtours.co.uk

  driver.navigate.to "http://www.airtours.co.uk"


# Click search button
begin
  url = driver.current_url
  sleep 10
  driver.find_element(:id, "idf-custom-select").click
  driver.find_element(:xpath, "//li[@class='custom-select-option'][3]").click
  driver.find_element(:name, "checkInDate").click
  2.times do
  driver.find_element(:xpath, "//a[@title='Next']").click
  end
  

  i = 1 
    begin
      driver.find_element(:xpath, "//div[@class='custom-select airportSelect']").click
      text = driver.find_element(:xpath, "//li[@class='custom-select-option optgroup-option'][#{i}]").text.scan(/[A-Z]{3}/).first
      driver.find_element(:xpath, "//li[@class='custom-select-option optgroup-option'][#{i}]").click
      driver.find_element(:name, "searchButton").click
      wait = Selenium::WebDriver::Wait.new(:timeout => 60)
      wait.until { driver.current_url.include? "results?arrival_point=#{text}" }
      url = driver.current_url
      i+=1
    end until url =~ /(.*)\/results(.*)/
  
  

rescue => exception
  puts "#{exception}"
  ret_ind = true
  while ret_ind == true do 
  puts "Exceptional situation occurred. What do you want to do? Press 'r' to retry, do the step manually and then press 'n' to move to the next step, press 's' to capture screenshot, press 't' to terminate the script."
   c = read_char
  case c
    when "r"
      puts "Retrying..."
      driver.navigate.refresh
      retry
    when "n"
      puts "Proceeding to the next step..."
      ret_ind = false
    when "t"
      puts "Executing teardown..."
      retval = 5
      teardown(driver,screenfile,retval)
    when "s"
      puts "Capturing screenshot..."
      driver.save_screenshot("airtours.co.uk/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"
    end
  end
end

# Click the first details button
begin
  url = driver.current_url
  driver.find_element(:name, "conflictResolvePanel:placeHolder:form:costButton").click
rescue => exception
  ret_ind = true
  while ret_ind == true do 
  puts "Exceptional situation occurred. What do you want to do? Press 'r' to retry, do the step manually and then press 'n' to move to the next step, press 's' to capture screenshot, press 't' to terminate the script."
   c = read_char
  case c
    when "r"
      puts "Retrying..."
      driver.navigate.refresh
      retry
    when "n"
      puts "Proceeding to the next step..."
      ret_ind = false
    when "t"
      puts "Executing teardown..."
      retval = 5
      teardown(driver,screenfile,retval)
    when "s"
      puts "Capturing screenshot..."
      driver.save_screenshot("airtours.co.uk/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"
    end
  end
end

#Click Book now
begin
  url = driver.current_url
  driver.find_element(:name, "checkoutFlow:next").click
rescue => exception
  ret_ind = true
  while ret_ind == true do 
  puts "Exceptional situation occurred. What do you want to do? Press 'r' to retry, do the step manually and then press 'n' to move to the next step, press 's' to capture screenshot, press 't' to terminate the script."
   c = read_char
  case c
    when "r"
      puts "Retrying..."
      driver.navigate.refresh
      retry
    when "n"
      puts "Proceeding to the next step..."
      ret_ind = false
    when "t"
      puts "Executing teardown..."
      retval = 5
      teardown(driver,screenfile,retval)
    when "s"
      puts "Capturing screenshot..."
      driver.save_screenshot("airtours.co.uk/#{screen_count}_#{screenfile}")
      screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"
    end
  end
end

puts "airtours.co.uk is well!"

teardown(driver,screenfile,retval)
