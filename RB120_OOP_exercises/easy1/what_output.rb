
# Take a look at the following code.
# What output does this code print? 
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name  #=> Fluffy
puts fluffy       #=> My name is FLUFFY
puts fluffy.name  #=> FLUFFY
puts name         #=> FLUFFY

# Fix this class so that there are no surprises for the developer.

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end
puts
name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name  #=> Fluffy
puts fluffy       #=> My name is FLUFFY
puts fluffy.name  #=> Fluffy
puts name         #=> Fluffy

puts
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name  #=> 42
puts fluffy       #=> My name is 42
puts fluffy.name  #=> 42
puts name         #=> 43

=begin
Further:

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

This code "works" because of that mysterious to_s call in 
Pet#initialize. However, that doesn't explain why this code 
produces the result it does. Can you?
A: relating to the last example:
name = 42: 42 to assigned to the local variable `name`

fluffy = Pet.new(name): When a new Pet instance is initialized, 
to_s is called on the object passed in as an argument and the 
return value of that is assigned to the instance variable @name. 
Note that the `to_s` is called from the class of the argument, 
having nothing to do with the `to_s` in the Pet class.

`name += 1`:The local variable name is incremented by one = 43

puts fluffy.name: puts call `to_s` on the argument fluffy.name,
but to_s`from within the Pet class overrides the String#to_s.
Upcase on a string (digit representation) does not change the 
value of `@name`, thus My name is 42 is output

puts fluffy.name: The string '42' has not been changed, 42 is output

puts name: `name` refers to the local variable that has been incremented to 43
=end
