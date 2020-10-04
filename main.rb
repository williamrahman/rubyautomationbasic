require 'selenium-webdriver'
require 'webdrivers'
require 'ffi'
require 'rspec'
require 'rspec/expectations'

singleton_class.prepend(RSpec::Matchers)

driver = Selenium::WebDriver.for:chrome
wait = Selenium::WebDriver::Wait.new(timeout: 2)


name_text_field = 'input#developer-name'
populate_button = 'input#populate'
remote_checkbox = 'input#remote-testing'
parallel_checkbox = 'input#background-parallel-testing'
os_windows_radio = 'input#windows'
select_box = 'select#preferred-interface'
tried_checkbox = 'input#tried-test-cafe'
slider_area = 'div.ui-slider'
slider_handle = 'span.ui-slider-handle'
span = 'span.ui-slider-handle'
text_area = 'textarea#comments'
submit_button = 'button#submit-button'

driver.navigate.to('https://devexpress.github.io/testcafe/example/')

expect(driver.current_url).to eq('https://devexpress.github.io/testcafe/example/')
expect(driver.find_element(:xpath, '//h1[text()="Example"]')).to be_displayed
expect(driver.find_element(:css, name_text_field).attribute('value')).to be_empty
expect(driver.find_element(:css, remote_checkbox)).not_to be_selected
expect(driver.find_element(:css, submit_button)).not_to be_enabled

# driver.find_element(:css, name_text_field).send_keys('William Team')
driver.find_element(:css, populate_button).click
driver.switch_to.alert.accept
wait.until { driver.find_element(:xpath, '//h1[text()="Example"]').displayed?}
driver.find_element(:css, remote_checkbox).click
driver.find_element(:css, parallel_checkbox).click
wait.until { driver.find_element(:css, submit_button).enabled?}

driver.find_element(:css, os_windows_radio).click

select_box = driver.find_element(:css, select_box)
options = Selenium::WebDriver::Support::Select.new(select_box)
options.select_by(:text, 'Both')

driver.find_element(:css, tried_checkbox).click
wait.until do 
    driver.find_element(:css, slider_area).enabled? &&
    driver.find_element(:css, slider_handle).enabled? &&
    driver.find_element(:css, text_area).enabled?
end

expect(driver.find_element(:css, slider_area)).to be_enabled
expect(driver.find_element(:css, slider_handle)).to be_enabled
expect(driver.find_element(:css, text_area)).to be_enabled

slider = driver.find_element(:css, slider_area)
slider_handle = driver.find_element(:css, slider_handle)

slider_size = slider.size
slide_width = slider_size.width

driver.action.move_to(slider_handle).drag_and_drop_by(slider_handle, slide_width * 3/9, 0).perform
driver.find_element(:css, text_area).send_keys('MANTAP MANTAP MANTAP')
driver.find_element(:css, submit_button).click

wait.until{ driver.current_url != 'https://devexpress.github.io/testcafe/example/' }

expect(driver.current_url).not_to eq('https://devexpress.github.io/testcafe/example/')
expect(driver.find_element(:css, 'h1').text).to include('Peter Parker')