require 'rails_helper'

describe 'Usuário vê detalhes de um modelo de produto' do
  it 'e ve todas as informações' do
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                email: 'samsung@example.com') 
    ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 45,
                        depth: 10,sku: 'TV32-SAMSU-XPTO-ELET',supplier: supplier)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'TV 32'
    #Assert
    expect(page).to have_content ('TV 32')
    expect(page).to have_content ('SKU: TV32-SAMSU-XPTO-ELET')
    expect(page).to have_content ('Fornecedor: Samsung')
    expect(page).to have_content ('Dimensão: 70cm x 45cm x 10cm')
    expect(page).to have_content ('Peso: 8000g')
  end
  it 'e acessa os detalhes do fornecedor' do
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                email: 'samsung@exemplo.com') 
    ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 45,
                          depth: 10,sku: 'TV32-SAMSU-XPTO-ELET',supplier: supplier)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'TV 32'
    click_on 'Samsung'
    #Assert
    expect(page).to have_content 'Samsung Eletronica'
    expect(page).to have_content 'Apelido: Samsung'
    expect(page).to have_content 'Número de registro: 00.280.273/0001-00'
    expect(page).to have_content 'Endereço: Avenida Oitis, 1400 - Manaus - AM'
    expect(page).to have_content 'email: samsung@exemplo.com'
  end
end