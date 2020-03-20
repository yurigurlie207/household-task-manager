class CreateTasksTable < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :estimated_duration
      t.date :deadline
      t.string :priority
      t.text :notes
      t.boolean :no_subtask
    end
  end
end
