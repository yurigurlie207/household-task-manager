class CreateUserTasksTable < ActiveRecord::Migration[6.0]
  def change
    create_table :user_tasks do |t|
     t.integer :user_id
     t.integer :task_id
     t.integer :subtask_id
  end
end
