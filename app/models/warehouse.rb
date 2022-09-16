class Warehouse < ApplicationRecord
  validates :name, :description, :code, :address, :city, :state, :cep, :area, presence: true
  validates :name, :code, uniqueness: true
end
