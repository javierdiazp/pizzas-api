class Order < ApplicationRecord
  validates :total, presence: true
  belongs_to :store
  has_and_belongs_to_many :products

  def self.create_with_products(store_id, product_ids)
    products = Product.joins(:stores).where(id: product_ids, stores: { id: store_id })

    if products.count != product_ids.count
      raise ActiveRecord::RecordNotFound, "Couldn't find all Products with 'id': #{product_ids}"
    end

    total = products.sum(:price)

    Order.transaction do
      @order = create!(store_id: store_id, total: total)
      @order.update(product_ids: product_ids)
      return @order
    end
  end
end
