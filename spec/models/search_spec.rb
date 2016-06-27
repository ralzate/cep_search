require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:cep) }
    it { is_expected.to validate_length_of(:cep) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'callbacks' do
    it 'should call CEPSearchService and assign its response if valid' do
      body = {
          "bairro" => "Setor Institucional",
          "cep" => "76872862",
          "cidade" => "Ariquemes",
          "estado" => "RO",
          "logradouro" => "Rio Madeira ",
          "tipoDeLogradouro" => "Rua"
      }
      response = instance_double("HTTParty::Response", code: 200, body: body.to_json)
      allow(HTTParty).to receive(:get).and_return(response)
      search = Search.create(cep: 76872862)
      expect(search.status).to eq(200)
      expect(search.street).to eq("Rua Rio Madeira ")
      expect(search.city_state).to eq("Setor Institucional - Ariquemes (RO)")
    end

    it 'should not call CEPSearchService if given cep is invalid' do
      expect(CEPSearchService).not_to receive(:search)
      Search.create(cep: 123)
    end
  end
end
