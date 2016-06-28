require 'httparty'
class CEPSearchService
  def self.search(cep)
    attributes = {}
    begin
      response = HTTParty.get('http://correiosapi.apphb.com/cep/'+cep)
      body = JSON.parse response.body
      attributes[:status] = response.code
      if response.code == 200
        attributes[:street] = "#{body["tipoDeLogradouro"]} #{body["logradouro"]}"
        attributes[:city_state] = "#{body["bairro"]} - #{body["cidade"]} (#{body["estado"]})"
      elsif response.code == 404
        attributes[:error] = body["message"]
      else
        attributes[:error] = body
      end
    rescue HTTParty::Error
      attributes[:error] = "Erro na requisição. Por favor, tente novamente."
    rescue StandardError
      attributes[:error] = "Serviço indisponível :("
    end
    attributes
  end
end