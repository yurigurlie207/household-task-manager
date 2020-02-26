class Subtask < ActiveRecord::Base
    belongs_to :task
    has_many :users, :through => :task
    has_many :user_tasks
end
