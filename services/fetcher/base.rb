module Fetcher
  class Base
    BASE_URL = 'https://jsonplaceholder.typicode.com/todos/'.freeze

    private

    def fetch_todo(index)
      uri = URI("#{BASE_URL}#{index}")
      response = Net::HTTP.get(uri)
      Todo.from_json(response)
    end
  end
end
