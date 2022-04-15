class CreateBlackLists < ActiveRecord::Migration[7.0]
  def change
    create_table :black_lists do |t|
      t.string :token

      t.timestamps
    end
  end
end
