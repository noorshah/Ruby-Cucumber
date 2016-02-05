require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'rubocop/rake_task'


profiles = YAML::load(File.open(File.join(Dir.pwd, 'cucumber.yml')))
profiles.each do |name, value|
  desc "Run profile #{name}: #{value}"
  Cucumber::Rake::Task.new(name.to_sym, "Run profile #{name}: #{value}") do |t|
    t.profile = name
  end
end