module Ganttin
  class TaskStage < ActiveRecord::Base
    self.table_name = :task_stages

    belongs_to :task

    has_unique_identifier :id, length: 12, no_symbols: true

    def overdued?
      overdue > 0
    end

    def total_duration
      duration + overdue
    end
  end
end
