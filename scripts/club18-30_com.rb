require 'selenium-webdriver'
require 'fileutils'
require 'io/console'
require './scripts/functions.rb'

sitename = 'club18-30.com'
puts "Testing #{sitename}"
start_webdriver(sitename)

# Access club18-30.com

@driver.navigate.to 'http://www.club18-30.com'

# Click search button
begin
  puts 'Performing search...'
  url = @driver.current_url
  @driver.find_element(xpath: "//div[@class='custom-select departurePoint airportSelect']").click
  @driver.find_element(xpath: "//li[contains(text(), 'London - All Airports - (LON)')]").click

  @driver.find_element(name: 'checkInDate').click

  loop do
    @driver.find_element(xpath: "//a[@title='Next']").click
    month = @driver.find_element(xpath: "//span[@class='ui-datepicker-month']").text
    break if month == 'July'
  end

  @driver.find_element(xpath: "//a[@class='ui-state-default']").click

  location_list = %w(LCA , KGS , CFU , ZTH , PMI , HER , IBZ , BOJ)

  i = 0
  loop do
    @driver.find_element(xpath: "//div[@class='custom-select airportSelect']").click
    text = @driver.find_element(xpath: "//li[contains(text(), '#{location_list[i]}')]").text.scan(/[A-Z]{3}/).first
    @driver.find_element(xpath: "//li[contains(text(), '#{location_list[i]}')]").click
    @driver.find_element(name: 'searchButton').click
    wait = Selenium::WebDriver::Wait.new(:timeout, 120)
    wait.until { @driver.current_url.include? "results?arrival_point=#{text}" }
    url = @driver.current_url
    i += 1
    break if url =~ %r{(.*)\/results(.*)}
  end

rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

# Click the first details button
begin
  puts 'Choosing search result...'
  @driver.find_element(name: 'conflictResolvePanel:placeHolder:form:costButton').click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

# Click Book now
begin
  puts 'Booking...'
  @driver.find_element(name: 'checkoutFlow:next').click
rescue => exception
  exception_handler(exception, sitename)
  retry if @retry_flag == true
end

puts 'club18-30.com is well!'

stop_webdriver(@driver, @screenfile, @retval, sitename)
