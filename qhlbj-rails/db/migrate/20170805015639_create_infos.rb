class CreateInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :infos do |t|
      t.string :name
      t.string :logo
      t.string :intro

      t.timestamps
    end
  end
end
