require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #Arrange
    User.create!(name: 'João', email: 'exemplo@example.com', password: 'password')
    #Act
    visit root_path
    within ('nav') do
      click_on 'Entrar'
    end
    within ('form') do
      fill_in 'E-mail', with: 'exemplo@example.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end 
    #Assert
    expect(page).not_to have_link ('Entrar')
    expect(page).to have_button ('Sair')
    within ('nav') do
      expect(page).to have_content 'João - exemplo@example.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end
  it 'e faz logout' do
    #Arrange
    User.create!(email: 'exemplo@example.com', password: 'password')
    #Act
    visit root_path
    within ('nav') do
      click_on 'Entrar'
    end
    within ('form') do
      fill_in 'E-mail', with: 'exemplo@example.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end 
    click_on 'Sair'
    #Assert
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_link 'exemplo@example.com'
  end
end