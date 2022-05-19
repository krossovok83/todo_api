class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :task, null: false, foreign_key: true
      t.text :body
      t.text :image_data

      t.timestamps
    end
  end
end
