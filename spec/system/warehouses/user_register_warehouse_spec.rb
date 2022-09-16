require "rails_helper"

describe 'Usuário cadastra um galpão' do
  it 'a partir da tela inicial' do
    #Arrange

    #Act
    visit root_path
    click_on 'Criar Galpão'

    #Assert
    expect(page).to have_field('Nome')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Código')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Área')
  end
  it 'com sucesso' do
    #Arrange
    #Act
    visit root_path
    click_on 'Criar Galpão'
    fill_in 'Nome', with: 'São Paulo'
    fill_in 'Descrição', with: 'Galpão do aeroporto de São Paulo'
    fill_in 'Código', with: 'GRU'
    fill_in 'Endereço', with: 'Aeroporto de Guarulhos, 2000'
    fill_in 'Cidade', with: 'Guarulhos'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '18000-000'
    fill_in 'Área', with: '100000'
    click_on 'Criar Galpão'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content('Galpão cadastrado com sucesso!')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('GRU')
    expect(page).to have_content('100000 m²')
  end
  it 'com dados incompletos' do
    #Arrange

    #Act
    visit root_path
    click_on 'Criar Galpão' 
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Área', with: ''
    click_on 'Criar Galpão'

    #Assert
    expect(page).to have_content('Galpão não cadastrado.')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')
    expect(page).to have_content('CEP não pode ficar em branco')
    expect(page).to have_content('Área não pode ficar em branco')
  end  
end