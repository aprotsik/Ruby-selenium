#!/usr/bin/env ruby

require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
login_url = "http://www.thomascook.com"

msg = "All is well !"
retval = 0

begin
  driver.navigate.to login_url
  driver.manage.timeouts.implicit_wait = 0
rescue
  driver.quit
  msg = "Error loading #{login_url}"
  exit 5
end

puts msg

driver.close
driver.quit
exit retval