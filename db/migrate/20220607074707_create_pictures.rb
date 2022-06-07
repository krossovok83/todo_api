class CreatePictures < ActiveRecord::Migration[7.0]
  def change
    create_table :pictures do |t|
      t.references :comment, null: false, foreign_key: true
      t.text :image_data

      t.timestamps
    end

    remove_column :comments, :image_data
  end
end
