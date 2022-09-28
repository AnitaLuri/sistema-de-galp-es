require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Registrar Pedido'
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                                full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                                email: 'apple@example.com') 
    Supplier.create!(corporate_name: 'Samsung Computer Brasil', brand_name: 'Samsung', registration_numbers: '00.001.000/0001-00', 
                                full_address: 'Rua Couto, 800', city: 'São Paulo', state: 'SP',
                                email: 'samsung@example.com') 
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000, 
                                address: 'Avenida Brasil, 500', cep: '20000-000', description: 'Galpão principal do Rio de Janeiro') 
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                                address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                description: 'Galpão destinado para cargas internacionais')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC1234567')                            
    #Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'SDU - Rio', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '20/12/2022'
    click_on 'Criar Pedido'
    #Assert
    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido: ABC1234567'
    expect(page).to have_content 'Galpão Destino: SDU - Rio'
    expect(page).to have_content 'Fornecedor: Apple Computer Brasil'
    expect(page).to have_content 'Usuário responsável: Maria - test@example.com' 
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).not_to have_content 'Aeroporto SP'
    expect(page).not_to have_content 'Samsung Computer Brasil'
  end 
  it 'com dados incompletos' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    #Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    fill_in 'Data Prevista de Entrega', with: ' '
    click_on 'Criar Pedido'

    #Assert
    expect(page).to have_content('Não é possível registrar o pedido.')
    expect(page).to have_content('Galpão Destino é obrigatório(a)')
    expect(page).to have_content('Fornecedor é obrigatório(a)')
    expect(page).to have_content('Data Prevista de Entrega não pode ficar em branco')
  end  
end