require "rails_helper"

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    #Arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100000, 
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    warehouse_first = Warehouse.create(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', state: 'RJ', cep: '25000-000', 
                                  area: 20000, description: 'Alguma coisa sobre galpão')
    #Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Remover'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content('Galpão removido com sucesso')
    expect(page).not_to have_content('Aeroporto SP')
    expect(page).not_to have_content('GRU')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('RIO')
  end
end