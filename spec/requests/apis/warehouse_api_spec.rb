require 'rails_helper'

describe 'warehouse API' do
  context 'Get/api/v1/warehouse/1' do
    it 'sucess' do
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'
      
      json_response = JSON.parse(response.body)

      expect(json_response["name"]).to eq 'Aeroporto SP'
      expect(json_response["code"]).to eq 'GRU'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
    end
    it 'fail if warehouse not found' do
      get "/api/v1/warehouses/999999999"

      expect(response.status).to eq 404 
    end
  end
  context 'Get/api/v1/warehouse' do
    it 'sucess' do
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
      warehouse = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', state: 'AL',
                                  area: 50_000, address: 'Avenida Atlanta, 1000', cep: '80000-000',
                                  description: 'Galpão destinado para cargas estaduais')
  

      get "/api/v1/warehouses"

      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'
      
      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Aeroporto SP'
      expect(json_response[1]['name']).to eq 'Maceio'
    end
    it 'return empty if there is no warehouse' do
      get "/api/v1/warehouses"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      
      json_response = JSON.parse(response.body)

      expect(json_response).to eq []
    end
    it 'return empy if there is no warehouse' do
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/warehouses'

      expect(response).to have_http_status(500)
    end 
  end
  context 'POST /api/v1/warehouses' do
    it 'sucess' do
      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                      area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                      description: 'Galpão destinado para cargas internacionais'}
                          }

      post '/api/v1/warehouses', params: warehouse_params 

      expect(response).to have_http_status(201)
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response["name"]).to eq 'Aeroporto SP'
      expect(json_response["code"]).to eq 'GRU'
      expect(json_response["city"]).to eq 'Guarulhos'
      expect(json_response["state"]).to eq 'SP'
      expect(json_response["area"]).to eq 100_000
      expect(json_response["address"]).to eq 'Avenida do Aeroporto, 1000'
      expect(json_response["cep"]).to eq '15000-000'
      expect(json_response["description"]).to eq 'Galpão destinado para cargas internacionais'
    end
    it 'fail if parameters are not complete' do
      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU'}
                          }

      post '/api/v1/warehouses', params: warehouse_params 

      expect(response).to have_http_status(412)
      expect(response.body).to include 'Cidade não pode ficar em branco'
      expect(response.body).to include 'Estado não pode ficar em branco'
      expect(response.body).to include 'Área não pode ficar em branco'
      expect(response.body).to include 'Endereço não pode ficar em branco'
      expect(response.body).to include 'CEP não é válido'
      expect(response.body).to include 'Descrição não pode ficar em branco'
    end
    it 'fail if theres an internal error' do
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais'}
                          }

      post '/api/v1/warehouses', params: warehouse_params 

      expect(response).to have_http_status(500)
    end
  end
end 