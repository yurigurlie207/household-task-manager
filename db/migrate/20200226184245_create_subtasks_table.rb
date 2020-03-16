class CreateSubtasksTable < ActiveRecord::Migration[6.0]
  def change
    create_table :subtasks do |t|
      t.string :title
      t.integer :estimated_duration
      t.integer :actual_duration
      t.date :deadline
      t.string :priority
      t.text :notes
      t.text :feedback
      t.boolean :no_subtask
      t.integer :task_id
    end
  end
end
