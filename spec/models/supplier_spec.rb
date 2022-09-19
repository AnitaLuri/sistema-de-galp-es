require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when corporate name is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: '', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                email: 'apple@example.com') 

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end  
      it 'false when brand name is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'Apple Computer Brasil', brand_name: '', registration_numbers: '00.623.904/0001-00', 
                                full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                email: 'apple@example.com') 

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end  
      it 'false when registration numbers is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '', 
                                full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                email: 'apple@example.com') 

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end  
      it 'false when full address is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                full_address: '', city: 'São Paulo', state: 'SP',
                                email: 'apple@example.com') 

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end
      it 'false when city is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                full_address: 'Rua Leopoldo Couto, 700', city: '', state: 'SP',
                                email: 'apple@example.com') 

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end
      it 'false when state is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: '',
                                email: 'apple@example.com') 

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end
      it 'false when email is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                email: '') 

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end
    end
    it 'false when registration numbers is invalid' do
      #Arrange
      supplier = Supplier.new(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
      
      supplier_second = Supplier.new(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com')
      #Act

      #Assert
      expect(supplier.valid?).to eq false
      expect(supplier_second.valid?).to eq false
    end
    it 'false when email is invalid' do
      #Arrange
      supplier = Supplier.new(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'appleexample.com') 
      
      supplier_second = Supplier.new(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example,com')
      #Act

      #Assert
      expect(supplier.valid?).to eq false
      expect(supplier_second.valid?).to eq false
    end
  end
end
