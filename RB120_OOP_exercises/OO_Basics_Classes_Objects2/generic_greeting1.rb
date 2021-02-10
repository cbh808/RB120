=begin
Modify the following code so that Hello! I'm a cat! 
is printed when Cat.generic_greeting is invoked.
=end

class Cat
  def self.generic_greeting  # self refers to `Cat` class
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting



# `#generic_greeting` is invoked on the Cat class,
#  not on an instance of Cat.
# This indicates that it is a class method.

# What happens if you run `kitty.class.generic_greeting`? 
# Can you explain this result?

# A: `kitty` is an instance of the `Cat` class, therefore
# `kitty.class` is equivalent to 'Cat', and is valid call.
# output: "Hello! I'm a cat!"

kitty = Cat.new
kitty.class.generic_greeting