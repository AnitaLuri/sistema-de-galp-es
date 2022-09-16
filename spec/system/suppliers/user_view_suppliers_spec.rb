require "rails_helper"

describe 'Usuário vê fornecedores'  do
  it 'a partir do menu' do
    #Arrange
    #Act
    visit root_path
    within ('nav') do
      click_on 'Fornecedores'
    end
    
    #Assert
    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Lista de Fornecedores')
  end
  it 'e vê os fornecedores cadastrados' do
    #Arrange - cadastrar 2 galpoes: Rio e Maceio
    Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                    full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                    email: 'apple@example.com') 
    Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                    full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                    email: 'samsung@example.com') 

    #Act
    visit root_path
    click_on 'Fornecedores'
    
    #Assert
    expect(page).to have_content('Apple')
    expect(page).to have_content('São Paulo - SP')

    expect(page).to have_content('Samsung')
    expect(page).to have_content('Manaus - AM')
  end
  it 'e não existe forncedor cadastrado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(page).to have_content('Não existem fornecedores cadastrados')
  end
  it 'e volta para a página inicial' do
    # Arrange
    # Act
    visit root_path
    click_on 'Fornecedores' 
    click_on 'Voltar' 

    # Assert
    expect(current_path).to eq(root_path)
  end
end