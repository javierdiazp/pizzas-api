class Order < ApplicationRecord
  validates :total, presence: true
  belongs_to :store
end
