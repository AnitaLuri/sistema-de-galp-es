require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    first_user = User.create!(name: 'João', email: 'joao@example.com', password: '123456')
    supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', 
                              registration_numbers: '00.623.904/0001-00', full_address: 'Rua Leopoldo Couto, 700', 
                              city: 'São Paulo', state: 'SP', email: 'apple@example.com') 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                              description: 'Galpão destinado para cargas internacionais')
    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, 
                              supplier: supplier, sku: 'PRODUTO-A000-9999ABC')
    order =  Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now, status: :pending)     
    order_item = OrderItem.create!(product_model: product_a, order: order, quantity: 5)         
    
    login_as(first_user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Entregue'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Entregue'
    expect(page).not_to have_button 'Marcar como Cancelado'
    expect(page).not_to have_button 'Marcar como Entregue'
    expect(StockProduct.count).to eq 5
    estoque = StockProduct.where(product_model: product_a, warehouse: warehouse).count
    expect(estoque).to eq 5
  end
  it 'e pedido foi cancelado' do
    first_user = User.create!(name: 'João', email: 'joao@example.com', password: '123456')
    supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                              description: 'Galpão destinado para cargas internacionais')
    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, 
                              supplier: supplier, sku: 'PRODUTO-A000-9999ABC')
    order =  Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now, status: :pending)     
    order_item = OrderItem.create!(product_model: product_a, order: order, quantity: 5)         
 
    login_as(first_user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Cancelado'
  
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'
    expect(StockProduct.count).to eq 0
  end
end