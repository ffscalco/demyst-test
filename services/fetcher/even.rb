require_relative 'base'

module Fetcher
  class Even < Base
    def call
      index = 2
      todos = []

      while todos.length < limit
        todos << fetch_todo(index)
        index += 2
      end

      todos.compact
    end

    def batch_call
      indexes = (2..).step(2).take(limit)

      fetch_batch_todos(indexes)
    end
  end
end
