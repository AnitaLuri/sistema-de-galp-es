require "rails_helper"

describe 'Usuário cadastra um modelo de produtos' do
  it 'com sucesso' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica', brand_name: 'Samsung', registration_numbers: '00.280.273/0001-00', 
                                full_address: 'Avenida Oitis, 1400', city: 'Manaus', state: 'AM',
                                email: 'samsung@example.com') 
    #Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome' , with: 'TV 32'
    fill_in 'Peso', with: '8000'
    fill_in 'Largura', with: '70'
    fill_in 'Altura', with: '45'
    fill_in 'Profundidade', with: '10'
    fill_in 'SKU', with: 'SOU71-SAMSU-NOIZ77'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Criar Modelo de Produto'
    
    #Assert
    expect(page).to have_content 'Modelo de Produto cadastrado com sucesso'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'SKU: SOU71-SAMSU-NOIZ77'
    expect(page).to have_content 'Dimensão: 70cm x 45cm x 10cm'
    expect(page).to have_content 'Peso: 8000g'
  end
end

