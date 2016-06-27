require 'rails_helper'

RSpec.describe CEPSearchService, type: :service do
  describe ".search" do
    it "should make the request to the API with given CEP and parse the result" do
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
      search = CEPSearchService.search(76872862)
      expect(search[:status]).to eq(200)
      expect(search[:street]).to eq("Rua Rio Madeira ")
      expect(search[:city_state]).to eq("Setor Institucional - Ariquemes (RO)")
    end

    it "should set error if given cep was not found" do
      body = { message: "CEP não Encontrado!" }
      response = instance_double("HTTParty::Response", code: 404, body: body.to_json)
      allow(HTTParty).to receive(:get).and_return(response)
      search = CEPSearchService.search(76872862)
      expect(search[:status]).to eq(404)
      expect(search[:error]).to eq(body[:message])
    end

    it "should set error if bad request" do
      body = { "error" => "Bad Request" }
      response = instance_double("HTTParty::Response", code: 400, body: body.to_json)
      allow(HTTParty).to receive(:get).and_return(response)
      search = CEPSearchService.search(76872862)
      expect(search[:status]).to eq(400)
      expect(search[:error]).to eq(body)
    end
  end
end