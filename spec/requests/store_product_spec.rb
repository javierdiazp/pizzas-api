require 'rails_helper'

RSpec.describe 'Stores Products API', type: :request do
  let!(:products) { create_list(:product, 10) }
  let(:old_product_id) { products.first.id }
  let(:new_product_id) { create(:product).id }

  let!(:store_id) do
    store = create(:store)
    store.products << products
    return store.id
  end

  describe 'GET /stores/:store_id/products' do
    before { get "/stores/#{store_id}/products" }

    it 'returns products' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /stores/:store_id/products/:id' do
    before { put "/stores/#{store_id}/products/#{new_product_id}" }

    context 'when both records exists' do
      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the store does not exist' do
      let(:store_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Store/)
      end
    end

    context 'when the product does not exist' do
      let(:new_product_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end

    context 'when the product is already in the store' do
      let(:new_product_id) { old_product_id }

      it 'returns status code 409' do
        expect(response).to have_http_status(:conflict)
      end

      it 'returns an already exists message' do
        expect(response.body).to match(/Key \(store_id, product_id\)=\(\d+, \d+\) already exists/)
      end
    end
  end

  describe 'DELETE /stores/:store_id/products/:id' do
    before { delete "/stores/#{store_id}/products/#{old_product_id}" }

    context 'when both records exists' do
      it 'deletes the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the store does not exist' do
      let(:store_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Store/)
      end
    end

    context 'when the product does not exist' do
      let(:old_product_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end

    context 'when the product is not in the store' do
      let(:old_product_id) { new_product_id }

      it 'does nothing' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
