class Task < ActiveRecord::Base
  has_many :user_tasks
  has_many :subtasks
  has_and_belongs_to_many :users
end
