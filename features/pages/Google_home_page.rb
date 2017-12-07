require_relative '../../features/pages/Base_page'

class Google_home_page < Base_page
  include PageObject
  page_url $BASE_URL
  text_field :search_field, css: 'input[title=Search]'
  link :apple_pie_recipe, text: 

  def search_for_apple_pie
    self.search_field='apple pie'
    # self.send_keys :enter
  end
  
  def view_apple_pie_recipes
    sleep 1
    @browser.link(:text => /apple pie recipe/).click
    puts @browser.title
  end
 
end