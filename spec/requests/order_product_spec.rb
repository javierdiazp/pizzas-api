require 'rails_helper'

RSpec.describe 'Orders Products API', type: :request do
  let!(:products) { create_list(:product, 10) }
  let!(:order_id) do
    order = create(:order)
    order.products << products
    return order.id
  end

  describe 'GET /orders/:order_id/products' do
    before { get "/orders/#{order_id}/products" }

    it 'returns products' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
