require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #Arrange
    User.create!(email: 'exemplo@example.com', password: 'password')
    #Act
    visit root_path
    click_on 'Entrar'
    within ('form') do
      fill_in 'E-mail', with: 'exemplo@example.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end 
    #Assert
    expect(page).not_to have_link ('Entrar')
    expect(page).to have_button ('Sair')
    within ('nav') do
      expect(page).to have_content 'exemplo@example.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end
  it 'e faz logout' do
    #Arrange
    User.create!(email: 'exemplo@example.com', password: 'password')
    #Act
    visit root_path
    click_on 'Entrar'
    within ('form') do
      fill_in 'E-mail', with: 'exemplo@example.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end 
    click_on 'Sair'
    #Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_link 'exemplo@example.com'
  end
end