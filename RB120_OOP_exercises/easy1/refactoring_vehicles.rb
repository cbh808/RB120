=begin
Refactor the classes so they use a common superclass, 
and inherit behavior as needed.
=end

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

# Further Exploration
=begin
Would it make sense to define a wheels method in Vehicle even 
though all of the remaining classes would be overriding it?
=> yes
Why or why not?
=> you could define a new vehicle with an arbitrary number of wheels
If you think it does make sense, 
what method body would you write?
create an @wheels instance variable and initialize to passed in value or default 0
define wheels in attr reader
=end