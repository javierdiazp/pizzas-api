class Product < ApplicationRecord
  validates :name, :sku, :type, :price, presence: true
  validates :type, inclusion: %w[Pizza Complement]

  # The word 'type' is restricted in Active Record models as it is used for inheritance
  # In order to meet the requirement, this behaviour must be overridden
  self.inheritance_column = :_type_disabled
end
