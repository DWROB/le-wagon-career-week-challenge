# le-wagon-career-week-challenge
practice on a technical challenge for career week

# Brief
We're looking for a small Ruby on Rails application providing an endpoint which takes a GPS latitude and
longitude and spits out the names of museums around that location grouped by their postcode as JSON.
Mapbox provides a handy API endpoint for fetching museums around a location(youwill need to create a
free account for getting an API key to use their API).
As an example when doing a request to /museums?lat=52.494857&lng=13.437641 would
generate a response similar to:
{
  "10999": ["Werkbundarchiv – museum of things"],
  "12043": ["Museum im Böhmischen Dorf"],
  "10179": [
    "Märkisches Museum",
    "Museum Kindheit und Jugend",
    "Historischer Hafen Berlin"
  ],
  "12435": ["Archenhold Observatory"]
 }
 
 # initial considerations
 
 Having some familiarity with the mapbox API I turned to the documentation and began to look for the endpoints and optional 
 parameters I would need to complete the task. 
 
 As the task requests that the method work with longitude and latitude as input, I read the documentation about
 'reverse geocoding'.  After I understand this, I continue a search through the documentation to see if there
 are any more specific guidelines for this case.  
 
 # proximity
 
 this is key for the task as I don't want to find a museum at exact coordinates.  So I need to ensure that I enter
 long and lat as the value of the 'proximity' parameter.  
 
 The documentation clarifies that you can enter the text 'museum.json' to search for this object.  However, you
 should also include type=poi in the parameters to ensure the call filter 'points of interest'. 
 
 
 # postman
 Now with a notional URL to test, I use Postman to ensure that I am getting the correct result, before
 writing any Ruby code.  
 
 https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=-0.125096,51.522184?&access_token={token}
 
 I choose some coordinates and call the above URL.   
 N.B. IF YOU TAKE COORDINATES FOR TESTING FROM GOOGLE MAPS, YOU MUST BE AWARE THAT GOOGLE ORDERS LAT-LONG,
 SO TO SUCCEED YOU SHOULD FLIP THE ORDER OF ANY COORD YOU COPY FROM GOOGLE MAPS.
 
 I use postman to examine the response.  Within the response are 'features' an array containing museum objects.
 feature["text"] provides the name of the museum.  
 
 # Ruby code
 I define method that takes two parameters, long and lat.   
 
 I install dotenv gem to conceal my private API Token, and ensure the .env file is entered on my gitignore file.

A small stumbling block in this implementation was that the position of the post-code was inconsistent.  Within the 'context' array,
nested within features, the post code would not always be positioned in the same index.  In my tests, for example, in
UK addresses the postcode was position in index [1], but in Germany, the postcode was in the [0] index.  

I created a second loop to search the 'context' array and took the value only from the index that contained the word
'postcode'.  After a few tests with various cities, the results seemed consistent.
