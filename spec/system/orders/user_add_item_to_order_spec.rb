require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    user = User.create!(name: 'João', email: 'joao@example.com', password: '123456')
    supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODUTO-A000-9999ABC')
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODUTO-B000-9999ABC')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                              description: 'Galpão destinado para cargas internacionais')
    order =  Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now)          
                              
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Modelo do Produto'
    fill_in 'Quantidade', with: '12'
    click_on 'Criar Item do Pedido'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '12 x Produto A'
  end
  it 'e não vê produtos de outro fornecedor' do
    user = User.create!(name: 'João', email: 'joao@example.com', password: '123456')
    supplier_a = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
    supplier_b = Supplier.create!(corporate_name: 'Samsung Computer Brasil', brand_name: 'Samsung', registration_numbers: '00.001.000/0001-00', 
                              full_address: 'Rua Couto, 800', city: 'São Paulo', state: 'SP',
                              email: 'samsung@example.com') 
    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier_a, sku: 'PRODUTO-A000-9999ABC')
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier_b, sku: 'PRODUTO-B000-9999ABC')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                              description: 'Galpão destinado para cargas internacionais')
    order =  Order.create!(user: user, warehouse: warehouse, supplier: supplier_a, 
                              estimated_delivery_date: 1.day.from_now)          
                              
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
   
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
end