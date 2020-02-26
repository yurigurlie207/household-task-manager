class Task < ActiveRecord::Base
  has_many :user_tasks
  has_many and belongs_to :users
  has_many :subtasks
end
