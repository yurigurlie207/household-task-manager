class Task < ActiveRecord::Base
  has_many :subtasks
  has_many :users, :through => :subtasks
end
