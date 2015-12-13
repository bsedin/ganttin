class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.string :user_id, index: true, null: false
      t.string :project_id, index: true, null: false
      t.string :roles, array: true
    end
    add_foreign_key :project_members, :users
    add_foreign_key :project_members, :projects
  end
end
