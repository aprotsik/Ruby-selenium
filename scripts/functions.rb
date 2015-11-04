require 'selenium-webdriver'
require 'fileutils'
require 'io/console'

# Method, which creates the instance of webdriver, tuning some of it's parameters and defines some major variables. 

def start_webdriver(sitename)
	client = Selenium::WebDriver::Remote::Http::Default.new
	client.timeout = 300
	@driver = Selenium::WebDriver.for(:firefox, :http_client => client) 
	@retval = 0
	@screenfile = "#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
	@ret_ind = true
	@screen_count = 1
	FileUtils.mkdir_p "#{sitename}"
	FileUtils.rm_rf(Dir.glob("#{sitename}/*"))
	@driver.manage.window.maximize
	@driver.manage.timeouts.page_load = 120 # Page load timeout.
	@driver.manage.timeouts.implicit_wait = 60 # Default timeout to look for element. Can be overriddent, if explicit wait is used. (wait object instance, created right before the driver.find_element)
end

# Method, which terminates webdriver object instance, saving the screenshot of success or failure.

def stop_webdriver(driver,screenfile,retval,sitename)
  	sleep 5
  	driver.save_screenshot("#{sitename}/#{screenfile}")
  	driver.quit
  	exit retval  
end

# Method, responsible for user input.

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

# Error handling method, which allows several way of dealing with exceptional situations.

def exception_handler(exception,sitename)
  @retry_flag = false
  puts "#{exception}"
  @ret_ind = true
  while @ret_ind == true do 
  puts "Exceptional situation occurred. What do you want to do? Press 'r' to retry, do the step manually and then press 'n' to move to the next step, press 's' to capture screenshot, press 't' to stop the script (screenshot will also be made)."
   c = read_char
  case c
    when "r"
      puts "Retrying..."
      @driver.navigate.refresh
      @retry_flag = true
      @ret_ind = false
    when "n"
      puts "Proceeding to the next step..."
      @ret_ind = false
    when "t"
      puts "Stopping webdriver..."
      @retval = 5
      @screenfile = "Fail_#{Time.now.strftime("%d.%m.%Y__%H'%M'%S")}.jpg"
      stop_webdriver(@driver,@screenfile,@retval,sitename)
    when "s"
      puts "Capturing screenshot..."
      @driver.save_screenshot("#{sitename}/#{@screen_count}_#{@screenfile}")
      @screen_count += 1
    else
      puts "Character not recognized! Please push some of those, mantioned in the description!"  
    end
  end
end