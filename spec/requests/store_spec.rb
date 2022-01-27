require 'rails_helper'

RSpec.describe 'Stores API', type: :request do
  let!(:stores) { create_list(:store, 10) }
  let(:store_id) { stores.first.id }
  let(:valid_attributes) { attributes_for(:store) }

  describe 'GET /stores' do
    before { get '/stores' }

    it 'returns stores' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /stores/:id' do
    before { get "/stores/#{store_id}" }

    context 'when the record exists' do
      it 'returns the store' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(store_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:store_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Store/)
      end
    end
  end

  describe 'POST /stores' do
    context 'when the request is valid' do
      before { post '/stores', params: valid_attributes }

      it 'creates a store' do
        expect(json['name']).to eq(valid_attributes[:name])
        expect(json['address']).to eq(valid_attributes[:address])
        expect(json['email']).to eq(valid_attributes[:email])
        expect(json['phone']).to eq(valid_attributes[:phone])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { valid_attributes.reject { |k| k == :name } }

      before { post '/stores', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /stores/:id' do
    let(:partial_attributes) { valid_attributes.slice(:name, :address) }

    before { put "/stores/#{store_id}", params: partial_attributes }

    context 'when the record exists' do
      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the record does not exist' do
      let(:store_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Store/)
      end
    end
  end

  describe 'DELETE /stores/:id' do
    before { delete "/stores/#{store_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
