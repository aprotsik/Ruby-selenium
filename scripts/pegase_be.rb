require 'selenium-webdriver'
require 'fileutils'
require 'io/console'
require './scripts/functions.rb'

sitename = 'pegase.be'
puts "Testing #{sitename}"
start_webdriver(sitename)

# Access neckermann.be

@driver.navigate.to 'https://www.pegase.be/'

# Click search button
begin
  puts 'Performing search...'
  # Children
  # Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'qsmNumberOfAdults_room_1')).select_by value: '2'
  # Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'qsmNumberOfChildren_room_1')).select_by value: '0'
  @driver.find_element(id: 'QsmListerOrFullTextSearch_/sitecore/content/eComHome/Configuration/common/Components/ShopPegase/QSM/VelocityQsmGeneral_label').click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

# Click the first details button
begin
  puts 'Choosing search result...'
  @driver.find_element(id: 'QsmDetailLink_1').click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

# Click Book now
begin
  puts 'Booking...'
  @driver.find_element(id: 'calcbuttonspan').click
  @driver.find_element(xpath: "//span[@class='label bookNowButton']").click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

# Fill the passenger details
begin
  puts 'Filling passenger details...'
  sleep 5
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_gender')).select_by :value, 'Male'
  @driver.find_element(id: 'TravellerDetails_1_firstName').send_keys 'Luke'
  @driver.find_element(id: 'TravellerDetails_1_lastName').send_keys 'Skywalker'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_days')).select_by :value, '13'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_months')).select_by :value, '6'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_years')).select_by :value, '1990'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_2_gender')).select_by :value, 'Female'
  @driver.find_element(id: 'TravellerDetails_2_firstName').send_keys 'Mara'
  @driver.find_element(id: 'TravellerDetails_2_lastName').send_keys 'Skywalker'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_2_days')).select_by :value, '25'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_2_months')).select_by :value, '4'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_2_years')).select_by :value, '1992'
  @driver.find_element(id: 'foSubmit').click

  fail 'There are some empty fields!'  if @driver.find_element(id: 'personaliaMandatoryFieldExplanation').displayed? == true

rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

# Click Next button
begin
  puts 'Some tour information...'
  @driver.find_element(id: 'btnNext').click
  # @driver.find_element(id: 'optionsandextrasInsurancePopupYesBtn').click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

# Fill the passenger details (more)
begin
  puts 'More passenger details...'
  @driver.find_element(id: 'TravellerDetails_1_street').send_keys 'Rokin'
  @driver.find_element(id: 'TravellerDetails_1_houseNumber').send_keys '1'
  @driver.find_element(id: 'TravellerDetails_1_zipCode').send_keys '1012 KT'
  @driver.find_element(id: 'TravellerDetails_1_city').send_keys 'Amsterdam'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_country')).select_by :value, 'NL'
  @driver.find_element(id: 'TravellerDetails_1_mobilePhoneNumber').send_keys '+31 30 2357822'
  @driver.find_element(id: 'TravellerDetails_1_email1').send_keys 'luke.skywalker@gmail.com'
  @driver.find_element(id: 'ConfirmEmailAddress').send_keys 'luke.skywalker@gmail.com'
  @driver.find_element(id: 'toPaymentButton').click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

puts 'pegase.be is well!'

stop_webdriver(@driver, @screenfile, @retval, sitename)
