class AddCarouselIdToGoods < ActiveRecord::Migration[5.1]
  def change
    add_column :goods, :carousel_id, :integer
  end
end
