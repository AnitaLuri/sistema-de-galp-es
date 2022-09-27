require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
      #Act
      result = user.description()
      #Assert
      expect(result).to eq ('Maria - test@example.com')
    end
  end
end
