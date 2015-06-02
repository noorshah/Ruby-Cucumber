Given(/^I am on google$/) do 
 visit Google_home_page
end

When(/^I enter apple pie$/) do
(on Google_home_page).search_for_apple_pie
end

Then(/^I get apple pie recipe$/) do
  (on Google_home_page).view_apple_pie_recipes
end