require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      #Arrange
      user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                    full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                    email: 'apple@example.com')   
      order =  Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                                      estimated_delivery_date: 1.day.from_now)                  
      #Act
      result = order.valid?
      #Assert
      expect(result).to be true
    end
    it 'data estimada deve ser obrigatória' do
      #Arrange 
      order =  Order.new(estimated_delivery_date: '')                  
      #Act
      order.valid?
      #Assert
      expect(order.errors.include? :estimated_delivery_date).to be true
    end
    it 'data estimada não deve ser passado' do
      #Arrange 
      order =  Order.new(estimated_delivery_date: 1.day.ago)                  
      #Act
      order.valid?
      #Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura')
    end
    it 'data estimada não deve ser hoje' do
      #Arrange 
      order =  Order.new(estimated_delivery_date: Date.today)                  
      #Act
      order.valid?
      #Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura')
    end
    it 'data estimada deve ser futura' do
      #Arrange 
      order =  Order.new(estimated_delivery_date: 1.day.from_now)                  
      #Act
      order.valid?
      #Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be false
    end
  end
  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      #Arrange
      user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                    full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                    email: 'apple@example.com')   
      order =  Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                                      estimated_delivery_date: Time.zone.tomorrow)                  
      #Act
      order.save!
      result = order.code
      #Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end
    it 'e o código é único' do
      #Arrange
      user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                    full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                    email: 'apple@example.com')   
      first_order =  Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                      estimated_delivery_date: Time.zone.tomorrow)    
      second_order =  Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                                      estimated_delivery_date: Time.zone.tomorrow)                                                      
      #Act
      second_order.save!
      #Assert
      expect(second_order.code).not_to eq first_order.code
    end
  end
end
