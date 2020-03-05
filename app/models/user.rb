class User < ActiveRecord::Base
  has_many :user_tasks
  has_many :subtasks, :through => :user_tasks
  has_many :tasks, :through => :subtasks

end
