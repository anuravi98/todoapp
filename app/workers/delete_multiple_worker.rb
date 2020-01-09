class DeleteMultipleWorker
  include Sidekiq::Worker

  def perform(todo_ids)
    Todo.destroy(todo_ids)
    
    # Do something
  end
end
