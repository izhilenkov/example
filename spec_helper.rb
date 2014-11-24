require 'watir-webdriver'
require 'rspec'
require 'nokogiri'
require 'allure-rspec'
require 'parallel_tests'
Dir["#{File.dirname(__FILE__)}/abstract_pages/*_page.rb"].each { |file| load file }

module SpecHelper
RSpec.configure do |c|
    c.include AllureRSpec::Adaptor
    c.before(:all) do
      @browser = local
      @browser.goto(base_url)
      @browser.window.resize_to(1280, 1024)
      @base_url = base_url
    end
    c.after(:all) do
      @browser.quit
    end
    c.after(:each) do |e|
      e.attach_file path_screen , screenshooting(@browser)
    end
end

AllureRSpec.configure do |c|
    c.output_dir = "" # base_url to jenkins's allure folder
end

def selenium_grid
  #Selenium Grid config
  caps = Selenium::WebDriver::Remote::Capabilities.chrome
  caps.platform = :WINDOWS
  caps[:name] = "Watir WebDriver"
  driver = Watir::Browser.new(
      :remote,
      :url => "http://192.168.1.5:4444/wd/hub",
      :desired_capabilities => caps)
end

def local
  #standart driver config
  driver = Watir::Browser.new :chrome
end

def path_screen
  path_screen = "./#{Time.now.strftime("screenshot_%d_%m_%Y__%H_%M_%S")}.png"
end

def screenshooting(driver)
  driver.screenshot.save path_screen
end

def base_url
    base_url = 'http://www' #current url here
end
end