class Subtask < ActiveRecord::Base
  has_many :user_tasks
  has_many :users
  belongs_to :task

end
