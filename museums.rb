require "json"
require "open-uri"

def museums(long, lat)
  url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{long},#{lat}?&access_token="
  response = URI.open(url).read
  museums_raw = JSON.parse(response)

  results = {}

  museums_raw["features"].each do |museum|
    museum["context"].each do |context|
      if context["id"].include? "postcode"
        results[context["text"]] = museum["text"]
      end
    end
  end
  results
end
