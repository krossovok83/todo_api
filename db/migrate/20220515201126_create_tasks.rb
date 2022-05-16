class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.datetime :deadline
      t.integer :position
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
