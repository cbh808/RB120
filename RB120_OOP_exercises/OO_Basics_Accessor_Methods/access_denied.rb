=begin
Modify the following code so that the value of @phone_number 
can still be read as on line 10, but cannot be changed as on 
line 12.

Comment: We need to ensure that @phone_number cannot be modified
from outside the class. To do this, we simply need to remove the
setter method by changing #attr_accessor to #attr_reader. 
This still lets us set the value of the @phone_number instance 
variable when instantiating the object, and lets us read its 
value from outside of the class, but doesn't let us modify it 
from outside the class.
=end

class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end
end

person1 = Person.new(1234567899)
puts person1.phone_number

person1.phone_number = 9987654321 # => NoMethodError
puts person1.phone_number