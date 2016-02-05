# Provides access to the Environment Config
#-------------------------------------------------------------------------------------------------------------
# Usage:
#
# EnvConfig.environment         Returns the current config environment, eg. "ci".
# EnvConfig.config              Returns the whole config hash.
# EnvConfig.data                Returns the test data loaded from support/data/* as a hash. Equivalent to EnvConfig['data']
# EnvConfig['some_key']         Returns the value of the key 'some_key' from the current config in config.yml
#
#-------------------------------------------------------------------------------------------------------------

require 'singleton'
require 'yaml'
# envconfig
class
EnvConfig
  include Singleton
  attr_reader :config
  attr_reader :environment

  def initialize
    config_yaml = File.join(Dir.pwd, 'config.yml')
    fail "Ooops. config.yml could not be found" unless File.exist?(config_yaml)
    config_file = YAML.load(File.open(config_yaml))

    # Get the current config setting from the environment. It should be passed in from the command line eg. CONFIG=ci (see rakefile)
    # It will use default_config from config.yaml if nothing is passed in.
    @environment = ENV['CONFIG']

    if @environment.nil?
      @environment = config_file.fetch('defaults').fetch('default_config') # .fetch() will fail an error if the keys aren't found.
      abort("No CONFIG supplied from command line, and no default_config found in config.yml") if @environment.nil?
    end

    # Load in data files from /features/support/data/*
    @test_data = {}

    Dir[File.dirname(__FILE__) + '/../features/support/data/*.yml'].each do |f|
      puts "Loading test data YAML from data directory..."

      data = YAML.load(File.open(f))
      @test_data.merge!(data)

      puts "Loaded #{f}"
    end

    @config = config_file[environment]
    # @config['data'] = @test_data
  end

  def self.[](key_name)
    instance.value_for(key_name)
  end

  def self.environment
    instance.environment
  end

  def self.config
    instance.config
  end

  def self.data
    instance.value_for('data')
  end

  def value_for(key_name)
    fail "There is no key '#{key_name}' for the config '#{@environment}' in config.yml" if @config[key_name].nil?
    @config[key_name]
  end
end
