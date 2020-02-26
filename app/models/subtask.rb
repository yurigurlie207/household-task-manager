class Subtask < ActiveRecord::Base
  has_many :user_tasks
  belongs_to :task
  has_and_belongs_to_many :users, :through => :task

end
