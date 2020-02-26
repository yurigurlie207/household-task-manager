class Subtask < ActiveRecord::Base
  has_many :user_tasks
  belongs_to :task
  has_many and belongs_to :users, :through => :task

end
