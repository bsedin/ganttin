module Ganttin
  class TimeEntry < ActiveRecord::Base
    self.table_name = :time_entries

    belongs_to :user
    belongs_to :task
    belongs_to :project

    has_unique_identifier :id, length: 40, no_symbols: true
  end
end
