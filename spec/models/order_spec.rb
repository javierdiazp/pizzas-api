require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:total) }
  it { is_expected.to belong_to(:store) }

  describe 'method: create with products' do
    let(:store) { create(:store) }
    let(:product_ids) do
      store.products << create_list(:product, 5)
      store.products.pluck(:id)
    end
    let!(:order) { described_class.create_with_products(store.id, product_ids) }

    context 'when there are products' do
      it 'associate the products' do
        expect(order.products.count).to eq(5)
      end

      it 'adds the prices' do
        expect(order.total).to eq(order.products.sum(:price))
      end
    end

    context 'when there are no products' do
      let(:product_ids) { [] }

      it 'adds zero' do
        expect(order.total).to eq(0)
      end
    end
  end
end
