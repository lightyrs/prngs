require 'net/http'
require 'json'

module Echonest

  API_KEY = 'DAAUDTGOP2UZ3GZSS'

  def self.extract(text)
    request_url = "http://developer.echonest.com/api/v4/artist/extract?api_key=#{API_KEY}&format=json&text=#{URI.encode(text)}&results=3"
    response = Net::HTTP.get(URI(request_url))
    response = JSON.parse(response)
    response = OpenStruct.new(response["response"])
    if response.status["message"] == "Success"
      response.artists.map do |artist|
        Artist.construct(OpenStruct.new(artist))
      end
    end
  end
end