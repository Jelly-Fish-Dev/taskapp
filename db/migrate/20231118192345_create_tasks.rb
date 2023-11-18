class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.references :assignee, null: false, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
