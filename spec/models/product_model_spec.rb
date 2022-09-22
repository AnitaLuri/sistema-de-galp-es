require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'name is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                  full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                  email: 'samsung@example.com') 
      pm = ProductModel.new(name: '',weight: 8000, width: 70, height: 45,
                            depth: 10, sku: 'TV32-SAMSU-XPTO', supplier: supplier)
      #Act
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end
    it 'sku is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                  full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                  email: 'samsung@example.com') 
      pm = ProductModel.new(name: 'TV 32',weight: 8000, width: 70, height: 45,
                            depth: 10, sku: '', supplier: supplier)
      #Act
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end
    it 'weight is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                  full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                  email: 'samsung@example.com') 
      pm = ProductModel.new(name: 'TV 32',weight: '', width: 70, height: 45,
                            depth: 10, sku: 'TV32-SAMSU-XPTO', supplier: supplier)
      #Act
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end
    it 'width is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                  full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                  email: 'samsung@example.com') 
      pm = ProductModel.new(name: 'TV 32',weight: 8000, width: '', height: 45,
                            depth: 10, sku: 'TV32-SAMSU-XPTO', supplier: supplier)
      #Act
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end
    it 'height is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                  full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                  email: 'samsung@example.com') 
      pm = ProductModel.new(name: 'TV 32',weight: 8000, width: 70, height: '',
                            depth: 10, sku: 'TV32-SAMSU-XPTO', supplier: supplier)
      #Act
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end
    it 'depth is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                  full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                  email: 'samsung@example.com') 
      pm = ProductModel.new(name: 'TV 32',weight: 8000, width: 70, height: 45,
                            depth: '', sku: 'TV32-SAMSU-XPTO', supplier: supplier)
      #Act
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end
    it 'false when sku is already in use' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                  full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                  email: 'samsung@example.com') 
      pm = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 45,
                            depth: 10, sku: 'TV32-SAMSU-XPTO', supplier: supplier)
      pm_second = ProductModel.new(name: 'TV 40',weight: 8000, width: 70, height: 45,
                                    depth: 10, sku: 'TV32-SAMSU-XPTO', supplier: supplier)
      #Act
      result = pm_second.valid?
      #Assert
      expect(result).to eq false
    end
  end
end
