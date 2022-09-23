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
    expect(page).to have_link 'Sair'
    within ('nav') do
      expect(page).to have_content 'exemplo@example.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end
end