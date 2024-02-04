require_relative 'base'

module Fetcher
  class Even < Base
    def initialize(limit)
      @limit = limit
    end
    def self.call(limit)
      new(limit).call
    end

    def call
      index = 2
      todos = []

      while todos.length < limit
        todos << fetch_todo(index)
        index += 2
      end

      todos
    end

    private

    attr_accessor :limit
  end
end
