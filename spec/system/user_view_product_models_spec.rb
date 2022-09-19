require'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'a partir do menu' do
    #Arrange
    #Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    #Assert
    expect(current_path).to eq product_models_path
  end
  it 'com sucesso' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                              full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                              email: 'samsung@example.com') 
    ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 45,
                          depth: 10,sku: 'TV32-SAMSU-XPTO',supplier: supplier)
    ProductModel.create!(name: 'SoundBar',weight: 3000, width: 80, height: 15,
                          depth: 20,sku: 'SOU71-SAMSU-NOIZ77',supplier: supplier)
    #Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    #Assert
    expect(page).to have_content('TV 32')
    expect(page).to have_content('TV32-SAMSU-XPTO')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('SoundBar')
    expect(page).to have_content('SOU71-SAMSU-NOIZ77')
    expect(page).to have_content('Samsung')
  end
  it 'e não existe produtos cadastrados' do
    #Arrange
    #Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    #Assert
    expect(page).to have_content('Nenhum modelo de produto cadastrado')
  end
end