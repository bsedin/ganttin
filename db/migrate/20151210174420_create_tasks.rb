class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.integer :number, null: false, default: 1
      t.string :project_id, index: true
      t.string :title
      t.string :body
      t.integer :time_spent, null: false, default: 0

      t.timestamps null: false
    end

    add_foreign_key :tasks, :projects
    add_index :tasks, [:project_id, :number]
  end
end
