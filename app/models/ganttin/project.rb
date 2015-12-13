module Ganttin
  class Project < ActiveRecord::Base
    self.table_name = :projects

    belongs_to :owner, class_name: 'User'
    has_many :tasks
    has_many :project_members, dependent: :destroy
    has_many :members, through: :project_members

    has_unique_identifier :id, length: 12
  end
end
