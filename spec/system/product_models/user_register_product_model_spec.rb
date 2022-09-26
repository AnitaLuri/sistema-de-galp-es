require "rails_helper"

describe 'Usuário cadastra um modelo de produtos' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                email: 'samsung@example.com') 
    other_supplier = Supplier.create!(corporate_name: 'LG Eletronica', brand_name: 'LG', registration_numbers: '00.280.273/0001-99', 
                                full_address: 'Avenida Oitis, 14', city: 'Manaus', state: 'AM',
                                email: 'lg@example.com') 
    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome' , with: 'TV 32'
    fill_in 'Peso', with: '8000'
    fill_in 'Largura', with: '70'
    fill_in 'Altura', with: '45'
    fill_in 'Profundidade', with: '10'
    fill_in 'SKU', with: 'SOU71-SAMS-NOIZ-ELET'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Criar Modelo de Produto'
    
    #Assert
    expect(page).to have_content 'Modelo de Produto cadastrado com sucesso'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'SKU: SOU71-SAMS-NOIZ-ELET'
    expect(page).to have_content 'Dimensão: 70cm x 45cm x 10cm'
    expect(page).to have_content 'Peso: 8000g'
  end
  it 'deve preencher todos os campos' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                email: 'samsung@example.com') 

    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'SKU', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Profundidade', with: ''
    click_on 'Criar Modelo de Produto'

    #Assert
    expect(page).to have_content('Modelo de Produto não cadastrado.')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('SKU não pode ficar em branco')
    expect(page).to have_content('Peso não pode ficar em branco')
    expect(page).to have_content('Largura não pode ficar em branco')
    expect(page).to have_content('Altura não pode ficar em branco')
    expect(page).to have_content('Profundidade não pode ficar em branco')
  end
  it 'com SKU unico' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                email: 'samsung@example.com') 
    pm = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 45,
                                depth: 10, sku: 'TV32-SAMSU-XPTO-ELET', supplier: supplier)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 40'
    fill_in 'SKU', with: 'TV32-SAMSU-XPTO-ELET'
    fill_in 'Peso', with: '8000'
    fill_in 'Largura', with: '70'
    fill_in 'Altura', with: '45'
    fill_in 'Profundidade', with: '10'
    click_on 'Criar Modelo de Produto'
    #Assert
    expect(page).to have_content('Modelo de Produto não cadastrado.')
    expect(page).to have_content('SKU já está em uso')
  end
  it 'com peso e dimensões com valores invalidos' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                email: 'samsung@example.com') 
    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 40'
    fill_in 'SKU', with: 'TV32-SAMSU-XPTO-ELET'
    fill_in 'Peso', with: '0'
    fill_in 'Largura', with: '-70'
    fill_in 'Altura', with: '0'
    fill_in 'Profundidade', with: '-10'
    click_on 'Criar Modelo de Produto'
    #Assert
    expect(page).to have_content('Modelo de Produto não cadastrado.')
    expect(page).to have_content('Peso deve ser maior que 0')
    expect(page).to have_content('Largura deve ser maior que 0')
    expect(page).to have_content('Altura deve ser maior que 0')
    expect(page).to have_content('Profundidade deve ser maior que 0')
  end
end

