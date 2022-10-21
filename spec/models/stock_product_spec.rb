require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um novo StockProduct' do
      user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                    full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                    email: 'apple@example.com')   
      product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, 
                                    supplier: supplier, sku: 'PRODUTO-A000-9999ABC')        
      order =  Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                    estimated_delivery_date: Time.zone.tomorrow)                  
      
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model:product_a)

      expect(stock_product.serial_number).not_to be_empty
      expect(stock_product.serial_number.length).to eq 10
    end
    it 'e o código é único' do
      user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                    full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                    email: 'apple@example.com')   
      product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, 
                                    supplier: supplier, sku: 'PRODUTO-A000-9999ABC')        
      order_a =  Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                    estimated_delivery_date: Time.zone.tomorrow)                  
      order_b =  Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                    estimated_delivery_date: Time.zone.tomorrow) 

      stock_product_a = StockProduct.create!(order: order_a, warehouse: warehouse, product_model:product_a)
      stock_product_b = StockProduct.create!(order: order_b, warehouse: warehouse, product_model:product_a)

      expect(stock_product_a.serial_number).not_to eq stock_product_b.serial_number
    end
    it 'e não deve ser modificado' do
      user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                    full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                    email: 'apple@example.com')   
      product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, 
                                    supplier: supplier, sku: 'PRODUTO-A000-9999ABC')  
      product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, 
                                    supplier: supplier, sku: 'PRODUTO-B000-9999ABC')                
      order_a =  Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                    estimated_delivery_date: Time.zone.tomorrow)                  
      stock_product = StockProduct.create!(order: order_a, warehouse: warehouse, product_model:product_a)
      original_serial = stock_product.serial_number

      stock_product.update!(product_model: product_b)

      expect(stock_product.serial_number).to eq(original_serial)
    end
  end
end
