Given(/^I am noot$/) do
  Watir::Browser.default = 'chrome'
  @browser = Watir::Browser.new

  @browser.goto "http://google.com"
  end

When(/^I got married$/) do
  
end

Then(/^I got fat$/) do
 
end
