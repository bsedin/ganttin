class CreateTaskStages < ActiveRecord::Migration
  def change
    create_table :task_stages, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :title
      t.string :task_id, index: true, null: false
      t.integer :duration, null: false, default: 0
      t.integer :overdue, null: false, default: 0

      t.timestamps null: false
    end
    add_foreign_key :task_stages, :tasks
  end
end
