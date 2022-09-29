require 'rails_helper'

describe 'Usuário vê seus proprios pedidos' do
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Meus Pedidos'
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'e não vê outros pedidos' do
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
    second_order =  Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now)   
    third_order =  Order.create!(user: second_user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now)
    #Act
    login_as(first_user)
    visit root_path
    click_on 'Meus Pedidos'
    #Assert
    expect(page).to have_content '2 pedidos encontrados'
    expect(page).to have_content first_order.code
    expect(page).to have_content second_order.code
    expect(page).not_to have_content third_order.code

  end
end 