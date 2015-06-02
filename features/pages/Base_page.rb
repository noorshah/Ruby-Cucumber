class Base_page
  include PageObject
  include PageObject::PageFactory
  
  attr_accessor :browser
  
  def initialize(browser,visit=false)
    super(browser,visit)
  end
  
end