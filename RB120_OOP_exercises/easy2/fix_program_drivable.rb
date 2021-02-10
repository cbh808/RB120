=begin
Correct the following program so it will work properly. 
Assume that the Car class has a complete implementation; 
just make the smallest possible change to ensure that 
cars have access to the drive method.
=end

module Drivable
  # remove self prefix which defined a class method
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive

# Methods in mixin modules should be defined without using self.
# the method would not be available at all as an instance method to objects.