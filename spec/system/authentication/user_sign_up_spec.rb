require 'rails_helper'

describe 'Usuario se autentica' do
  it 'com sucesso' do
    #Arrange

    #Act
    visit root_path
    within ('nav') do
      click_on 'Entrar'
    end
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Maria'
    fill_in 'E-mail', with: 'test@example.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    #Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso'
    expect(page).to have_content 'Olá Maria'
    expect(page).to have_content 'test@example.com'
    expect(page).to have_button 'Sair'
  end
end