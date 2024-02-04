module Fetcher
  class Base
    BASE_URL = 'https://jsonplaceholder.typicode.com/todos/'.freeze

    private

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
