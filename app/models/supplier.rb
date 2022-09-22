class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_numbers, :full_address, :city, :state, :email, presence: true
  validates :corporate_name, :brand_name, :registration_numbers, uniqueness: true
  validates :state, length: { is: 2 }
  validates :registration_numbers, format: { with: /\A[0-9]{2}\.[0-9]{3}\.[0-9]{3}\/[0-9]{4}\-[0-9]{2}\z/i }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
