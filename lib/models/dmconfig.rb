require 'dm-core'
require 'dm-migrations'
require_relative './user'

DataMapper::Logger.new($stdout, :debug)

if ENV['RACK_ENV'] == 'test'
  connection_string = "postgres://localhost/login_counter_test"
elsif ENV['RACK_ENV'] == 'development'
  connection_string = "postgres://localhost/login_counter_development"
end

DataMapper.setup(:default, connection_string)
DataMapper.finalize
DataMapper.auto_upgrade!