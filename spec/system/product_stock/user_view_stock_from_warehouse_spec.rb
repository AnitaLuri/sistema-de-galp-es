require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela do galpão' do
    user = User.create!(name: 'João', email: 'joao@example.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                              description: 'Galpão destinado para cargas internacionais')
    supplier_a = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
    supplier_b = Supplier.create!(corporate_name: 'Samsung Computer Brasil', brand_name: 'Samsung', registration_numbers: '00.001.000/0001-00', 
                              full_address: 'Rua Couto, 800', city: 'São Paulo', state: 'SP',
                              email: 'samsung@example.com') 
    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, 
                              supplier: supplier_a, sku: 'PRODUTO-A000-9999ABC')
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, 
                              supplier: supplier_b, sku: 'PRODUTO-B000-9999ABC')
    product_c = ProductModel.create!(name: 'Produto C', weight: 15, width: 10, height: 20, depth: 30, 
                              supplier: supplier_b, sku: 'PRODUTO-C000-9999ABC')
    order =  Order.create!(user: user, warehouse: warehouse, supplier: supplier_a, 
                              estimated_delivery_date: 1.day.from_now)    
    3.times{StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a)}
    2.times{StockProduct.create!(order: order, warehouse: warehouse, product_model: product_b)}
  
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'

    expect(page).to have_content 'Itens em Estoque'
    expect(page).to have_content '3 x PRODUTO-A000-9999ABC - Produto A'
    expect(page).to have_content '2 x PRODUTO-B000-9999ABC - Produto B'
    expect(page).not_to have_content 'PRODUTO-C000-9999ABC'
  end
end