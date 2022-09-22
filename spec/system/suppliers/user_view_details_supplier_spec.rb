require "rails_helper"

describe 'Usuário vê detalhes de um fornecedor' do
  it 'e vê informações adicionais' do
    # Arrange
    Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                      full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                      email: 'apple@example.com') 

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Apple'

    # Assert
    expect(page).to have_content('Apple Computer Brasil')
    expect(page).to have_content('Número de registro: 00.623.904/0001-00')
    expect(page).to have_content('Endereço: Rua Leopoldo Couto, 700 - São Paulo - SP')
    expect(page).to have_content('email: apple@example.com')
  end
  it 'e volta para a página inicial' do
    # Arrange
    Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                      full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                      email: 'apple@example.com') 

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Apple'
    click_on 'Home' 

    # Assert
    expect(current_path).to eq(root_path)
  end
end