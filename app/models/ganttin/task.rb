module Ganttin
  class Task < ActiveRecord::Base
    self.table_name = :tasks

    belongs_to :author, class_name: 'User'
    belongs_to :project
    has_many :task_members, dependent: :destroy
    has_many :members, through: :task_members
    has_many :time_entries

    has_unique_identifier :id, length: 12

    before_create :ensure_number

    private

    def ensure_number
      self.number = project.tasks.count + 1
    end
  end
end
