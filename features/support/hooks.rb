browser = Watir::Browser.new :chrome
Before do
  @browser = browser
end

After do |scenario|
  if scenario.failed?
    output_path = File.expand_path(File.dirname(__FILE__) + '/../../TestResults/screenshots/')
    scenario_name = scenario.name + " #{Time.now.strftime("%d-%m-%y %H.%M.%S")}"
    output_path += '/' + scenario_name + '.png'
    @browser.driver.save_screenshot(output_path)
    encoded_img = @browser.driver.screenshot_as(:png)
    embed("data:image/png;base64,#{encoded_img}", 'image/png')
  end

end


at_exit do
browser.close
end

