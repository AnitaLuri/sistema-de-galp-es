require 'rails_helper'

describe 'Usuário edita um pedido' do 
  it 'e não é o dono' do
    #Arrange
    first_user = User.create!(name: 'João', email: 'joao@example.com', password: '123456')
    second_user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                              description: 'Galpão destinado para cargas internacionais')
    order =  Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now)   
    #Act
    login_as(second_user)
    patch(order_path(order.id), params: { order: {supplier_id: 3 }})

    #Assert
    expect(response).to redirect_to(root_path)
  end
end