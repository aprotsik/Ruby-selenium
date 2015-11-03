require 'selenium-webdriver'
require 'fileutils'
require 'io/console'

def start

	client = Selenium::WebDriver::Remote::Http::Default.new
	client.timeout = 300
	driver = Selenium::WebDriver.for(:firefox, :http_client => client) 
	retval = 0
	screenfile = "#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
	ret_ind = true
	screen_count = 1

	FileUtils.mkdir_p 'thomascook.com'
	FileUtils.rm_rf(Dir.glob('thomascook.com/*'))

	driver.manage.window.maximize
	driver.manage.timeouts.page_load = 120
	driver.manage.timeouts.implicit_wait = 30 

end