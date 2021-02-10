=begin
Add the appropriate accessor methods to the following code.
=end

class Person
  attr_writer :name
  attr_reader :name
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name
