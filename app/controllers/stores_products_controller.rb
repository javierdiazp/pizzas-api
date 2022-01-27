class StoresProductsController < ApplicationController
  before_action :set_store
  before_action :set_product, only: %i[update destroy]

  def index
    json_response(@store.products)
  end

  def update
    @store.products << @product
    head :no_content
  end

  def destroy
    @store.products.delete(@product)
    head :no_content
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
