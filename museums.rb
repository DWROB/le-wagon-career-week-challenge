require "json"
require "open-uri"

def museums(long, lat)
  url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{long},#{lat}?&access_token=pk.eyJ1IjoiZWNvbm9taWMxODAxIiwiYSI6ImNsYTJuNzEzcjBqdzgzd3A5YnJ4aWRpZTAifQ.dCd6Lx2csqaemAfs5TsKYA"
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
# -0.125096,51.522184
# 38.72174555464688, -9.136853310424444
long = "-9.136853310424444"
lat = "38.72174555464688"

p museums(long, lat)
