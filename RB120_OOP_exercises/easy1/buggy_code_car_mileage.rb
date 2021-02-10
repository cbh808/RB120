=begin
Fix the following code so it works properly:
=end

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total #add self prefix to mileage == 'provide an explicit caller'
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678

=begin
Note: could have used `@mileage = total`
but `@mileage = total` bypasses the setter method entirely, 
which may not be what you want.

It's generally safer to use an explicit self. caller when you 
have a setter method unless you have a good reason to 
use the instance variable directly.

We say that calling the setter method, if available, is safer 
because using the instance variable bypasses any checks or 
operations performed by the setter, e.g.
def mileage=(miles)
  @mileage = miles.to_i  # the to_i would be missed
end
=end