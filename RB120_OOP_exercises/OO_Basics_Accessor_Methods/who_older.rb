=begin
Using the following code, add the appropriate accessor methods. 
Keep in mind that @age should only be visible to instances of 
Person.
=end

class Person
  attr_writer :age

  def older_than?(other)
    self.age > other.age
  end

  # protected methods allow access between class instances, 
  # while private methods don't.
  protected

  attr_reader :age

end

person1 = Person.new
person1.age = 17

person2 = Person.new
person2.age = 26

puts person1.older_than?(person2)