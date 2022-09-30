require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    #Arrange
    first_user = User.create!(name: 'João', email: 'joao@example.com', password: '123456')
    supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                              description: 'Galpão destinado para cargas internacionais')
    first_order =  Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now)   
    #Act
    visit edit_order_path(first_order.id)

    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    #Arrange
    first_user = User.create!(name: 'João', email: 'joao@example.com', password: '123456')
    first_supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
    second_supplier =  Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                              full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                              email: 'samsung@example.com') 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                              description: 'Galpão destinado para cargas internacionais')
    first_order =  Order.create!(user: first_user, warehouse: warehouse, supplier: first_supplier, 
                              estimated_delivery_date: 1.day.from_now)   
    #Act
    login_as(first_user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on first_order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: '12/12/2022'
    select 'Samsung Eletronica', from: 'Fornecedor'
    click_on 'Atualizar Pedido'
    #Assert
    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: Samsung Eletronica'
    expect(page).to have_content 'Data Prevista de Entrega: 12/12/2022'
  end
  it 'caso seja o responsável' do
    #Arrange
    first_user = User.create!(name: 'João', email: 'joao@example.com', password: '123456')
    second_user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                              description: 'Galpão destinado para cargas internacionais')
    first_order =  Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now)   
    #Act
    login_as(second_user)
    visit edit_order_path(first_order.id)

    #Assert
    expect(current_path).to eq root_path
  end
end