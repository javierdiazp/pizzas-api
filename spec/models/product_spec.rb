require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:sku) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_inclusion_of(:type).in_array(%w[Pizza Complement]) }
  it { is_expected.to have_and_belong_to_many(:stores) }
  it { is_expected.to have_and_belong_to_many(:orders) }
end
