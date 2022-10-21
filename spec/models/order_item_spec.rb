require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '#valid?' do
    it 'false quando a quantidade ficar em branco' do
      #Arrange
      user = User.create!(name: 'João', email: 'joao@example.com', password: '123456')
      supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                email: 'apple@example.com') 
      product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODUTO-A000-9999ABC')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                                address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                description: 'Galpão destinado para cargas internacionais')
      order =  Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now)               
      order_item = OrderItem.new(product_model: product_a, order: order, quantity: '')                
      
      expect(order_item.valid?).to be false
    end
  end
end
