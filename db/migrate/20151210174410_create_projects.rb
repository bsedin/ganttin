class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :title
      t.integer :tasks_count
      t.integer :members_count

      t.timestamps null: false
    end
  end
end
