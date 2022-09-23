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
  it 'e vê relação de modelos de produtos vinculado ao fornecedor' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
    ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 45,
                        depth: 10,sku: 'TV32-SAMSU-XPTO-ELET',supplier: supplier)
    ProductModel.create!(name: 'SoundBar',weight: 3000, width: 80, height: 15,
                        depth: 20,sku: 'SOU71-SAMS-NOIZ-ELET',supplier: supplier)
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Apple'
    #Assert
    expect(page).to have_content 'Nome'
    expect(page).to have_content 'SKU'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPTO-ELET'
    expect(page).to have_content 'SoundBar'
    expect(page).to have_content 'SOU71-SAMS-NOIZ-ELET'
  end
  it 'e não tem nenhum modelo de procuto vinculado' do
  supplier = Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', registration_numbers: '00.623.904/0001-00', 
                              full_address: 'Rua Leopoldo Couto, 700', city: 'São Paulo', state: 'SP',
                              email: 'apple@example.com') 
  supplier_second = Supplier.create!(corporate_name: 'Samsung Computer Brasil', brand_name: 'Samsung', registration_numbers: '00.001.000/0001-00', 
                              full_address: 'Rua Couto, 800', city: 'São Paulo', state: 'SP',
                              email: 'samsung@example.com') 
  ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 45,
                              depth: 10,sku: 'TV32-SAMSU-XPTO-ELET',supplier: supplier)                            
   #Act
   visit root_path
   click_on 'Fornecedores'
   click_on 'Samsung'
   #Assert
   expect(page).to have_content 'Nenhum modelo de produto cadastrado para esse fornecedor.'
  end
end