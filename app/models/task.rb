class Task < ActiveRecord::Base
  has_many :user_tasks
  has_many :subtasks
  has_many :users
end
