ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'

require_relative '../../lib/controllers/login_counter'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  LoginCounter.new
end

describe LoginCounter do

end  