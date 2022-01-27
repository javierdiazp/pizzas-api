class OrdersProductsController < ApplicationController
  before_action :set_order

  def index
    json_response(@order.products)
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end
end
