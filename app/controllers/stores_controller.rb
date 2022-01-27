class StoresController < ApplicationController
  before_action :set_store, only: %i[show update destroy]

  def index
    @stores = Store.all
    json_response(@stores)
  end

  def create
    @store = Store.create!(store_params)
    json_response(@store, :created)
  end

  def show
    json_response(@store)
  end

  def update
    @store.update(store_params)
    head :no_content
  end

  def destroy
    @store.destroy
    head :no_content
  end

  private

  def store_params
    params.permit(:name, :address, :email, :phone)
  end

  def set_store
    @store = Store.find(params[:id])
  end
end
