class DeleteMultipleWorker
  include Sidekiq::Worker

  def perform(todo_ids)
    Todo.destroy(todo_ids)
    UserMailer.send_email(@user.email)
    # Do something
  end
end
