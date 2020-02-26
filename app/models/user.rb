class User < ActiveRecord::Base
  has_many :user_tasks
  has_and_belongs_to_many :subtasks :through => :tasks
  has_and_belongs_to_many :tasks
end
