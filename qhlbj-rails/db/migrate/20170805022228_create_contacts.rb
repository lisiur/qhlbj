class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :mobile
      t.string :telphone
      t.string :address
      t.string :email
      t.string :qq
      t.string :weibo
      t.string :weixin

      t.timestamps
    end
  end
end
