require 'json'

class Todo
  attr_accessor :user_id, :id, :title, :completed

  def initialize(user_id:, id:, title:, completed:)
    @user_id = user_id
    @id = id
    @title = title
    @completed = completed
  end

  def self.from_json(json_data)
    todo_data = JSON.parse(json_data)
    new(
      user_id: todo_data['userId'],
      id: todo_data['id'],
      title: todo_data['title'],
      completed: todo_data['completed']
    )
  end

  def to_s
    "Title: #{title}\nCompleted: #{completed}\n------------------------"
  end
end
