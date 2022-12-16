require "json"
require "open-uri"

def museums(long, lat)
  url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{long},#{lat}?&access_token=pk.eyJ1IjoiZWNvbm9taWMxODAxIiwiYSI6ImNsYTJuNzEzcjBqdzgzd3A5YnJ4aWRpZTAifQ.dCd6Lx2csqaemAfs5TsKYA"
  response = URI.open(url).read
  museums_raw = JSON.parse(response)

  results = {}

  museums_raw["features"].each do |museum|
    results[museum["context"][1]["text"]] = museum["text"]
  end
  results
end

long = "13.437641"
lat = "52.494857"

museums(long, lat)
