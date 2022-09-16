require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        #Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', state: 'RJ', cep: '25000-000', 
                                  area: '20000', description: 'Alguma coisa sobre galpão')

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false
      end  
      it 'false when code is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: '', address: 'Endereço',
                                  city: 'Rio de Janeiro', state: 'RJ', cep: '25000-000', 
                                  area: '20000', description: 'Alguma coisa sobre galpão')

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false 
      end  
      it 'false when address is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: '',
                                  city: 'Rio de Janeiro', state: 'RJ', cep: '25000-000', 
                                  area: '20000', description: 'Alguma coisa sobre galpão')

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false 
      end  
      it 'false when city is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
                                  city: '', state: 'RJ', cep: '25000-000', 
                                  area: '20000', description: 'Alguma coisa sobre galpão')

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false 
      end 
      it 'false when state is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', state: '', cep: '25000-000', 
                                  area: '20000', description: 'Alguma coisa sobre galpão')

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false 
      end  
      it 'false when cep is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', state: 'RJ', cep: '', 
                                  area: '20000', description: 'Alguma coisa sobre galpão')

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false 
      end  
      it 'false when area is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', state: 'RJ', cep: '25000-000', 
                                  area: '', description: 'Alguma coisa sobre galpão')

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false 
      end  
      it 'false when description is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', state: 'RJ', cep: '25000-000', 
                                  area: '20000', description: '')

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false 
      end 
    end

    it 'false when code is already in use' do
      #Arrange 
      warehouse_first = Warehouse.create(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
                                      city: 'Rio de Janeiro', state: 'RJ', cep: '25000-000', 
                                      area: '20000', description: 'Alguma coisa sobre galpão')
      warehouse_second = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'Avenida',
                                      city: 'Niteroi', state: 'RJ', cep: '26000-000', 
                                      area: '21000', description: 'Alguma coisa sobre galpão de Niteroi')

      expect(warehouse_second.valid?).to eq false 
    end

    it 'false when name is already in use' do
      #Arrange 
      warehouse_first = Warehouse.create(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
                                      city: 'Rio de Janeiro', state: 'RJ', cep: '25000-000', 
                                      area: '20000', description: 'Alguma coisa sobre galpão')
      warehouse_second = Warehouse.new(name: 'Rio de Janeiro', code: 'RIN', address: 'Avenida',
                                      city: 'Niteroi', state: 'RJ', cep: '26000-000', 
                                      area: '21000', description: 'Alguma coisa sobre galpão de Niteroi')

      expect(warehouse_second.valid?).to eq false 
    end
  end
end
 