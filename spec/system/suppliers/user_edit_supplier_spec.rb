require "rails_helper"

describe 'Usuário edita um fornecedor cadastrado' do
  it 'a partir da página de detalhes' do
    #Arrange
    Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                      full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                      email: 'samsung@example.com') 

    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'Editar'
    #Assert
    expect(page).to have_content('Editar Fornecedor')
    expect(page).to have_field('Nome corporativo', with: 'Samsung Eletronica')
    expect(page).to have_field('Apelido', with: 'Samsung')
    expect(page).to have_field('Número de registro', with: '00.280.273/0001-00')
    expect(page).to have_field('Endereço completo', with: 'Avenida Oitis, 1400')
    expect(page).to have_field('Cidade', with: 'Manaus')
    expect(page).to have_field('Estado', with: 'AM')
    expect(page).to have_field('email', with: 'samsung@example.com')
  end
  it 'com sucesso' do
    #Arrange
    Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                      full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                      email: 'samsung@example.com') 

    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'Editar'
    fill_in 'Nome corporativo', with: 'Samsung Brasil'
    fill_in 'Número de registro', with: '00.000.002/0002-00'
    fill_in  'email', with: 'samsungbrasil@example.com'
    click_on 'Atualizar Fornecedor'
    #Assert
    expect(page).to have_content('Fornecedor atualizado com sucesso')
    expect(page).to have_content('Samsung Brasil')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('00.000.002/0002-00')
    expect(page).to have_content('Avenida Oitis, 1400')
    expect(page).to have_content('Manaus')
    expect(page).to have_content('AM')
    expect(page).to have_content('samsungbrasil@example.com')
  end
  it 'e mantém os campos obrigatórios' do
    #Arrange
    Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                      full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                      email: 'samsung@example.com') 
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'Editar'
    fill_in 'Nome corporativo', with: ''
    fill_in 'Número de registro', with: ''
    fill_in  'email', with: ''
    click_on 'Atualizar Fornecedor'
    #Assert
    expect(page).to have_content('Não foi possível atualizar o fornecedor')
  end
end