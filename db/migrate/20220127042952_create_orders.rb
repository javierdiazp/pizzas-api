class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :total
      t.belongs_to :store, index: true, foreign_key: true

      t.timestamps
    end
  end
end
