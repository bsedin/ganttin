class CreateTaskMembers < ActiveRecord::Migration
  def change
    create_table :task_members do |t|
      t.string :user_id, index: true, null: false
      t.string :task_id, index: true, null: false
      t.string :roles, array: true
    end
    add_foreign_key :task_members, :users
    add_foreign_key :task_members, :tasks
  end
end
