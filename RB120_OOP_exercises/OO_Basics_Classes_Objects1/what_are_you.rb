=begin
Using the code from the previous exercise, add an #initialize method 
that prints I'm a cat! when a new Cat object is initialized.
=end

class Cat
  def initialize
    puts "I'm a cat!"
  end
end

kitty = Cat.new

# When defining a class, it is usually necessary to define the #initialize 
# method. #initialize is useful for setting up -- initializing -- an object 
# so the object is ready for immediate use.