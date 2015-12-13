class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :user_id, index: true, null: false
      t.string :project_id, index: true, null: false
      t.string :task_id, index: true, null: false
      t.integer :duration, null: false, default: 0
      t.string :body

      t.datetime :created_at, null: false
    end
    add_foreign_key :time_entries, :users
    add_foreign_key :time_entries, :projects
    add_foreign_key :time_entries, :tasks
  end
end
