class User < ActiveRecord::Base
  has_many :user_tasks
  has_many :subtasks :through => :tasks
  has_many and belongs_to :tasks
end
