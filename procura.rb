require 'selenium-webdriver'
require 'webdrivers'
require 'ffi'

driver = Selenium::WebDriver.for:chrome

driver.navigate.to('https://alfamart.procura.id/')

username = 'input#username'
password = 'input#password'
submit = '.btn-sm'
tender = '//segment/ui-view/segment/div//segment/div//section/segment/div/div/div/div/ul/li/div/a[@title="Proposal Tender"]'

driver.find_element(:css, username).send_keys('superadmin')
driver.find_element(:css, password).send_keys('test1234')
driver.find_element(:css, submit).click
driver.find_element(:css, tender).click


sleep 10



