class CreateSubtasks < ActiveRecord::Migration[6.0]
  def change
  create_table :users do |t|
    t.string :taskname
    t.string :location
    t.integer :estimated_duration
    t.integer :actual_duration
    t.date :deadline
    t.string :priority
    t.text :notes
    t.text :feedback
    t.integer :task_id
  end
end
