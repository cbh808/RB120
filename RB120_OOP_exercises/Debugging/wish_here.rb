# On lines 41 and 42 of our code, we can see that grace and ada 
# are located at the same coordinates. So why does line 39 output false? 
# Fix the code to produce the expected output.

class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false

=begin
Discussion:
add following method to G

def ==(other)
  latitude == other.latitude && longitude == other.longitude
end

The equivalence operator `==` is originally called on the `GeoLocation` object,
`ada.location`
Going up the method lookup chain, the BasicObject#== method is called, which
compares the two `Geolocation` objects to see if they are the same object,
i.e. have the same object_id, which they do not.
Therefore we want to actually check if the two objects have the same
latitude and longitude, therefore we create a `==` method in the GeoLocation class
to do just that.
=end
