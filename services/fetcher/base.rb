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

    def fetch_batch_todos(indexes)
      uri = URI(BASE_URL)
      query_params = indexes.map { |index| "id=#{index}" }.join('&')
      uri.query = query_params

      response = Net::HTTP.get_response(uri)

      if valid_response_status?(response)
        JSON.parse(response.body).map { |todo_data| Todo.from_json(todo_data.to_json) unless todo_data['id'].nil? }
      else
        []
      end

    rescue URI::InvalidURIError, Net::HTTPError
      nil
    end

    def valid_response?(response)
      valid_response_status?(response) && response.body.include?('id')
    end

    def valid_response_status?(response)
      response.is_a?(Net::HTTPSuccess)
    end
  end
end
