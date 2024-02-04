module Fetcher
  class Base
    BASE_URL = 'https://jsonplaceholder.typicode.com/todos/'.freeze

    def initialize(limit)
      @limit = limit
    end

    def self.call(limit)
      new(limit).call
    end

    private

    attr_accessor :limit

    def fetch_todo(index)
      uri = URI("#{BASE_URL}#{index}")
      response = Net::HTTP.get_response(uri)
      Todo.from_json(response.body) if valid_response?(response)
    rescue URI::InvalidURIError, Net::HTTPError
      nil
    end

    def valid_response?(response)
      response.is_a?(Net::HTTPSuccess) && response.body.include?('id')
    end
  end
end
