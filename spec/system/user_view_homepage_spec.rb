require "rails_helper"

describe 'Usuario visita tela inicial' do
  it 'e vê o nome da app' do
    #Arrange
    #Act
    visit root_path
    #Assert
    expect(page).to have_content('Galpões & Estoque')
  end
  it 'e vê os galpões cadastrados' do
    #Arrange - cadastrar 2 galpoes: Rio e Maceio
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000, 
                    address: 'Avenida Brasil, 500', cep: 20000-000, description: 'Galpão principal do Rio de Janeiro') 
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', state: 'AL', area: 50_000, 
                    address: 'Avenida Brasil, 500', cep: 20000-000, description: 'Galpão principal do Rio de Janeiro')

    #Act
    visit root_path
    
    #Assert
    expect(page).not_to have_content('Nenhum galpão cadastrado.')

    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m²')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m²')
  end
  it 'e não existe galpões cadastrados' do
    #Arrange
    #Act
    visit root_path
    #Assert
    expect(page).to have_content('Nenhum galpão cadastrado.')
  end
end