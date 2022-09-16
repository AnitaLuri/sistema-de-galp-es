class Warehouse < ApplicationRecord
  validates :name, :description, :code, :address, :city, :state, :cep, :area, presence: true
  validates :name, :code, uniqueness: true
  validates :state, length: { maximum: 2 }
  validates :cep, format: { with: /\A[0-9]{5}\-[0-9]{3}\z/i }
end
