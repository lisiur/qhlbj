class CreateGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :goods do |t|
      t.string :name
      t.text :description
      t.string :avatar
			t.integer :category_id

      t.timestamps
    end
  end
end
