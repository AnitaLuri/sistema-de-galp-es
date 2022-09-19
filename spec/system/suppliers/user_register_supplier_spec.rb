require "rails_helper"

describe 'Usuario cadastra um fornecedor' do
  it 'a partir da Fornecedores' do
    #Arrange

    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'

    #Assert
    expect(page).to have_field('Nome corporativo')
    expect(page).to have_field('Apelido')
    expect(page).to have_field('Número de registro')
    expect(page).to have_field('Endereço completo')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('email')
  end
  it 'com sucesso' do
    #Arrange
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Nome corporativo', with: 'Apple Computer Brasil'
    fill_in 'Apelido', with: 'Apple'
    fill_in 'Número de registro', with: '00.000.123/0001-00'
    fill_in 'Endereço completo', with: 'Rua Leopoldo Couto, 700'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'email', with: 'apple@example.com'
    click_on 'Criar Fornecedor'

    #Assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content('Apple')
    expect(page).to have_content('São Paulo - SP')
  end
  it 'com dados incompletos' do
    #Arrange

    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Nome corporativo', with: ''
    fill_in 'Apelido', with: ''
    fill_in 'Número de registro', with: ''
    fill_in 'Endereço completo', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'email', with: ''
    click_on 'Criar Fornecedor'

    #Assert
    expect(page).to have_content('Fornecedor não cadastrado.')
    expect(page).to have_content('Nome corporativo não pode ficar em branco')
    expect(page).to have_content('Apelido não pode ficar em branco')
    expect(page).to have_content('Número de registro não pode ficar em branco')
    expect(page).to have_content('Endereço completo não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')
    expect(page).to have_content('email não pode ficar em branco')
  end  
end