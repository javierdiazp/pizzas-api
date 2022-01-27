class OrdersController < ApplicationController
  before_action :set_order, only: %i[show destroy]

  def index
    @orders = Order.all
    json_response(@orders)
  end

  def create
    @order = Order.create_with_products(order_params[:store_id],
                                        order_params[:product_ids])
    json_response(@order, :created)
  end

  def show
    json_response(@order)
  end

  def destroy
    @order.destroy
    head :no_content
  end

  private

  def order_params
    params.permit(:store_id, product_ids: []).with_defaults(product_ids: [])
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
