require 'rails_helper'

RSpec.describe Store, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to have_and_belong_to_many(:products) }
  it { is_expected.to have_many(:orders).dependent(:delete_all) }
end
