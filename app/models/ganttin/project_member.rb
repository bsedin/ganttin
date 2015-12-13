module Ganttin
  class ProjectMember < ActiveRecord::Base
    self.table_name = :project_members

    belongs_to :project
    belongs_to :member, class_name: 'User', foreign_key: :user_id
  end
end
