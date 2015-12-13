module Ganttin
  class TaskMember < ActiveRecord::Base
    self.table_name = :task_members

    belongs_to :task
    belongs_to :member, class_name: 'User', foreign_key: :user_id
  end
end
