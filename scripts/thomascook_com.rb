require 'selenium-webdriver'
require 'fileutils'
require 'io/console'
require './scripts/functions.rb'

sitename = 'thomascook.com'
puts "Testing #{sitename}"
start_webdriver(sitename)

# Access thomascook.com

@driver.navigate.to 'http://www.thomascook.com'

# Click search button
begin
  puts 'Performing search...'
  @driver.find_element(id: 'when').click
  2.times do
    @driver.find_element(xpath: "//a[@title='Next']").click
  end
  @driver.find_element(xpath: "//a[@class='ui-state-default']").click
  @driver.find_element(id: 'SearchbarForm-submitBtn').click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

# Click the first details button
begin
  puts 'Choosing search result...'
  @driver.find_element(xpath: "//a[@class='btn btn-success detailsBtn']").click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

# Click Book now
begin
  puts 'Booking...'
  @driver.find_element(id: 'bookNow').click
  # @driver.find_element(:id, 'submit-extras').click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

begin
  wait = Selenium::WebDriver::Wait.new(:timeout, 3)
  wait.until { @driver.find_element(:class, 'add').click }
rescue
end

# Continue to signing forms
begin
  puts 'Customizing holiday...'
  sleep 2
  @driver.find_element(id: 'submit-extras').location_once_scrolled_into_view
  @driver.find_element(id: 'submit-extras').click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

# Fill the passenger details
begin
  puts 'Entering passenger details...'
  # sleep 1
  # @driver.find_element(:id => 'title').click
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'title')).select_by :text, 'Mr'
  @driver.find_element(id: 'name').send_keys 'Luke'
  @driver.find_element(id: 'surname').send_keys 'Skywalker'
  @driver.find_element(id: 'email').send_keys 'jediknight@gmail.com'
  @driver.find_element(id: 'leadPassengerConfirmEmail').send_keys 'jediknight@gmail.com'
  Postcode = @driver.find_element(id: 'postCode')
  Postcode.location_once_scrolled_into_view
  Postcode.send_keys 'E7 9AL'
  @driver.find_element(xpath: "//a[@class='btn btn-default get-address']").click
  sleep 5
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'addressSelect')).select_by :text, '1 EARLHAM GROVE'

  City = @driver.find_element(id: 'city')
  City.location_once_scrolled_into_view
  unless City.attribute('value').include? 'LONDON'
    fail 'City box does not contain LONDON'
  end

  CountryDropdown = @driver.find_element(id: 'country')
  CountryDropdown.location_once_scrolled_into_view
  Option = CountryDropdown.find_element(tag_name: 'option')
  unless Option.attribute('value').include? 'UK'
    fail 'Country box does not contain United Kingdom'
  end

  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'day')).select_by :text, '13'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'month')).select_by :text, 'June'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'year')).select_by :text, '1990'
  @driver.find_element(:id, 'contactNumber').send_keys '2072243688'
  @driver.find_element(:xpath, "//a[@class='btn btn-success noArrow pax-confirm']").click
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'title2Room1')).select_by :text, 'Mrs'
  @driver.find_element(:id, 'name2Room1').send_keys 'Mara'
  @driver.find_element(:id, 'surname2Room1').send_keys 'Skywalker'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'day2Room1')).select_by :text, '25'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'month2Room1')).select_by :text, 'April'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'year2Room1')).select_by :text, '1992'
  @driver.find_element(id: 'paxSubmit').click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

puts 'thomascook.com is well!'

stop_webdriver(@driver, @screenfile, @retval, sitename)
