
require 'watir-webdriver'
#require 'rubygems'
require 'selenium-webdriver'
require 'page-object'
require 'page-object/page_factory'
require_relative '../../env_config'
World(PageObject::PageFactory)
World(PageObject)


$ENVIRONMENTS=YAML.load(File.open(Dir.pwd+'/environments.yml'))
$BASE_URL=$ENVIRONMENTS['staging']

