class CreateStoreProductJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :stores, :products do |t|
      t.index [:store_id, :product_id], unique: true
    end
  end
end
