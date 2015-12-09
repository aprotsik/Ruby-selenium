require 'selenium-webdriver'
require 'fileutils'
require 'io/console'
require './scripts/functions.rb'

sitename = 'vrijuit.nl'
puts "Testing #{sitename}"
start_webdriver(sitename)

# Access vrijuit.nl
@driver.navigate.to 'http://vrijuit.nl'

# Click search button
begin
  puts 'Performing search...'
  # @driver.find_element(id: 'st_popup_acceptButton').click
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'qsmNumberOfAdults')).select_by :value, '2'
  Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'qsmNumberOfChildren')).select_by :value, '0'
  @driver.find_element(id: 'QsmListerOrFullTextSearch_/sitecore/content/eComHome/Configuration/Channels/Main/Pages/Home/QSM_label').click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

begin
  wait = Selenium::WebDriver::Wait.new(:timeout, 3)
  wait.until { @driver.find_element(id: 'st_popup_acceptButton').click }
rescue
end

# Click the first details button
begin
  puts 'Choosing search result...'
  @driver.find_element(:xpath, "//span[@class='label']").click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

url = @driver.current_url

# Click Book now
if url.include? 'NadDetailPage'
  begin
    puts 'Booking...'
    @driver.find_element(id: '#tabBar-Prices2').click
    @driver.find_element(xpath: "(//a[contains(@data-room, '1')])").click
    @driver.find_element(id: 'priceTicket-submitButton').click
  rescue => exception
    exception_handler(exception, sitename)
    retry if @retry_flag == true
  end
else
  begin
    puts 'Booking...'
    @driver.find_element(id: 'calcbuttonspan').click
    @driver.find_element(xpath: "//span[@class='label bookNowButton']").click
  rescue => exception
    exception_handler(exception, sitename)
    retry if @retry_flag == true
  end
end

if @driver.find_element(:class, 'booking-personalia-contactperson').text.include? 'contactpersoon'
  # Fill the passenger details
  begin
    puts 'Filling passenger details...'
    @driver.find_element(id: 'TravellerDetails_1_gender').click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_gender')).select_by :value, 'Male'
    @driver.find_element(id: 'TravellerDetails_1_firstName').send_keys 'Luke'
    @driver.find_element(id: 'TravellerDetails_1_lastName').send_keys 'Skywalker'
    @driver.find_element(id: 'TravellerDetails_1_days').click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_days')).select_by :text, '13'
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_months')).select_by :text, 'juni'
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_years')).select_by :text, '1990'
    @driver.find_element(id: 'TravellerDetails_2_gender').click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_2_gender')).select_by :value, 'Female'
    @driver.find_element(id: 'TravellerDetails_2_firstName').send_keys 'Mara'
    @driver.find_element(id: 'TravellerDetails_2_lastName').send_keys 'Skywalker'
    @driver.find_element(id: 'TravellerDetails_2_days').click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_2_days')).select_by :text, '25'
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_2_months')).select_by :text, 'apr'
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_2_years')).select_by :text, '1992'

    Gender = @driver.find_element(id: 'TravellerDetails_1_gender')
    unless Gender.attribute('value').include? 'Male'
      fail 'Some values are missing!'
    end

    Gender1 = @driver.find_element(id: 'TravellerDetails_2_gender')
    unless Gender1.attribute('value').include? 'Female'
      fail 'Some values are missing!'
    end

    @driver.find_element(id: 'foSubmit').click

  rescue => exception
    exception_handler(exception, sitename)
    retry if @retry_flag == true
  end

  # Click Next button
  begin
    puts 'Trip details...'
    @driver.find_element(id: 'btnNext').click
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
    @driver.find_element(id: 'TravellerDetails_1_phoneNumber').send_keys '+31 30 2357822'
    @driver.find_element(id: 'TravellerDetails_1_email1').send_keys 'luke.skywalker@gmail.com'
    @driver.find_element(id: 'ConfirmEmailAddress').send_keys 'luke.skywalker@gmail.com'
    @driver.find_element(id: 'emergencyContact').send_keys 'Obiwan'
    @driver.find_element(id: 'emergencyPhoneNumber').send_keys '+31 30 2357822'
    @driver.find_element(id: 'toPaymentButton').click
  rescue => exception
    exception_handler(exception, sitename)
    retry if @retry_flag == true
  end

  # Click Agree to pay
  begin
    puts 'Payment agreement...'
    @driver.find_element(id: 'NlPayAgreement').click
    @driver.find_element(id: 'defaultPaymentAgreed_label').click
  rescue => exception
    exception_handler(exception, sitename)
    retry if @retry_flag == true
  end

else
  begin
    puts 'Filling passenger details...'
    @driver.find_element(:class, 'radio').click
    @driver.find_element(id: 'TravellerDetails_1_firstName').clear
    @driver.find_element(id: 'TravellerDetails_1_firstName').send_keys 'Luke'
    @driver.find_element(id: 'TravellerDetails_1_lastName').clear
    @driver.find_element(id: 'TravellerDetails_1_lastName').send_keys 'Skywalker'
    @driver.find_element(id: 'TravellerDetails_1_days').click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_days')).select_by :text, '13'
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_months')).select_by :text, 'juni'
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_1_years')).select_by :text, '1990'
    @driver.find_element(xpath: "(//label[@class='radio'])[4]").click
    @driver.find_element(id: 'TravellerDetails_2_firstName').clear
    @driver.find_element(id: 'TravellerDetails_2_firstName').send_keys 'Mara'
    @driver.find_element(id: 'TravellerDetails_2_lastName').clear
    @driver.find_element(id: 'TravellerDetails_2_lastName').send_keys 'Skywalker'
    @driver.find_element(id: 'TravellerDetails_2_days').click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_2_days')).select_by :text, '25'
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_2_months')).select_by :text, 'apr'
    Selenium::WebDriver::Support::Select.new(@driver.find_element(id: 'TravellerDetails_2_years')).select_by :text, '1992'
    @driver.find_element(id: 'foSubmit').click
    sleep 5
    @driver.find_element(id: 'btnNext').click
    @driver.find_element(id: 'TravellerDetails_1_street').send_keys 'Rokin'
    @driver.find_element(id: 'TravellerDetails_1_houseNumber').send_keys '1'
    @driver.find_element(id: 'TravellerDetails_1_zipCode').send_keys '1012 KT'
    @driver.find_element(id: 'TravellerDetails_1_city').send_keys 'Amsterdam'
    @driver.find_element(id: 'TravellerDetails_1_phoneNumber').send_keys '+31 30 2357822'
    @driver.find_element(id: 'TravellerDetails_1_email1').send_keys 'luke.skywalker@gmail.com'
    @driver.find_element(id: 'ConfirmEmailAddress').send_keys 'luke.skywalker@gmail.com'
    @driver.find_element(id: 'emergencyContact').send_keys 'Obiwan'
    @driver.find_element(id: 'emergencyPhoneNumber').send_keys '+31 30 2357822'
    @driver.find_element(id: 'toPaymentButton').click
    @driver.find_element(xpath: "//label[contains(., 'Ik ga akkoord met de reisvoorwaarden')]").click
    @driver.find_element(id: 'defaultPaymentAgreed').click
  rescue => exception
    exception_handler(exception, sitename)
    retry if @retry_flag == true
  end
end

puts 'vrijuit.nl is well!'

stop_webdriver(@driver, @screenfile, @retval, sitename)
