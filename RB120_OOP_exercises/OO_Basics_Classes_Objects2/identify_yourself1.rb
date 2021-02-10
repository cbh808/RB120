=begin
Using the following code, add a method named #identify 
that returns its calling object.
=end

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p kitty.identify

# using #p to print the object calls #inspect which lets us 
# view the instance variables and values in addtion to object.
