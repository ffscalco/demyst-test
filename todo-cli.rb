require 'net/http'
require 'json'
require_relative 'models/todo'
require_relative 'services/fetcher/even'

puts "Fetching the first 20 even TODOs...\n------------------------"
Fetcher::Even.new(20).batch_call.each { |todo| puts todo.to_s }
