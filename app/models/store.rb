class Store < ApplicationRecord
  validates :name, :address, :email, :phone, presence: true
  has_and_belongs_to_many :products
  has_many :orders, dependent: :delete_all
end
