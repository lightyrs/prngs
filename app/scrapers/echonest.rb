require 'net/http'
require 'json'

module Echonest

  API_KEY = 'DAAUDTGOP2UZ3GZSS'

  def self.make_request(url)
    response = Net::HTTP.get(URI(url))
    response = JSON.parse(response)
    OpenStruct.new(response["response"])
  end

  def self.extract(text)
    url = "http://developer.echonest.com/api/v4/artist/extract?api_key=#{API_KEY}&format=json&text=#{URI.encode(text)}&results=3"
    response = make_request(url)
    if response.status["message"] == "Success"
      response.artists.map do |artist|
        Artist.construct(OpenStruct.new(artist))
      end
    end
  end

  def self.profile(artist)
    url = "http://developer.echonest.com/api/v4/artist/profile?api_key=#{API_KEY}&id=#{artist.echonest_id}&format=json&bucket=biographies&bucket=familiarity&bucket=hotttnesss&bucket=images"
    response = make_request(url)
    if response.status["message"] == "Success"
      response.artist do |artist_data|
        artist.update_attributes(
          :hotttness => artist_data["hotttness"],
          :familiarity => artist_data["familiarity"],
          :images => artist_data["images"],
          :biographies => artist_data["biographies"]
        )
      end
    end
  end
end