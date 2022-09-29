require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'a partir do menu' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    #Act
    login_as(user)
    visit root_path
    #Assert
    within ('header nav') do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_path
    #Assert
    within ('header nav') do
      expect(page).not_to have_field 'Buscar Pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end
  it 'e encontra um pedido' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000, 
                              address: 'Avenida Brasil, 500', cep: '20000-000', description: 'Galpão principal do Rio de Janeiro') 
    order =  Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now)
    #Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'
    #Assert
    expect(page).to have_content "Resultados da busca: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão Destino: SDU - Rio'
    expect(page).to have_content 'Fornecedor: Apple Computer Brasil'
  end
  it 'e encontra multiplos pedidos' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                              description: 'Galpão destinado para cargas internacionais')
    second_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000, 
                                address: 'Avenida Brasil, 500', cep: '20000-000', description: 'Galpão principal do Rio de Janeiro') 
    
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU1234567')
    first_order =  Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU7589634')                     
    second_order =  Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now)   

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('SDU0000000')
    third_order =  Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now)
    #Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'GRU'
    click_on 'Buscar'
    #Assert
    expect(page).to have_content '2 pedidos encontrados'
    expect(page).to have_content 'GRU1234567'
    expect(page).to have_content 'GRU7589634'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).not_to have_content 'SDU0000000'
    expect(page).not_to have_content 'Galpão Destino: SDU - Rio'
  end
end 