class User < ActiveRecord::Base
  has_many :user_tasks
  has_many :tasks
  has_many :subtasks :through => :tasks

end
