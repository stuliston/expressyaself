require './app'

require 'vcr'
require 'webmock'
require 'webmock/rspec'
include WebMock::API
WebMock.enable!

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end
