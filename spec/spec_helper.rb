#

require 'rubygems'
require 'bundler'
Bundler.setup :default, :test

require 'simplecov'
require 'coveralls'
Coveralls.wear!
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

require 'grape'
require 'rack/test'

Dir[File.join(File.dirname(__FILE__), "..", "app", "*.rb")].each do |file|
  require file
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

# EOF
