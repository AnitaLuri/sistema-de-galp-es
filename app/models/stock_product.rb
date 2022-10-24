class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model
  has_one :stock_product_destination

  before_validation :generate_serial_number, on: :create

  def available?
    if stock_product_destination.nil?
      return true
    end
    false
  end

  private
  def generate_serial_number
    self.serial_number = SecureRandom.alphanumeric(10).upcase
  end
end
