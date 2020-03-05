class Subtask < ActiveRecord::Base
  belongs_to :task
  has_many :user_tasks
  has_many :users, :through => :user_tasks


end
