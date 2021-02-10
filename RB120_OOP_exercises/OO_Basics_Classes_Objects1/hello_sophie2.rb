=begin
Using the code from the previous exercise, move the greeting
 from the #initialize method to an instance method named #greet 
 that prints a greeting when invoked.
=end

class Cat
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet

# Instance methods are written the same as any other method, 
# except they're only available when there's an instance of the class. 
# For example, kitty is an instance of the Cat class. 
# This means, if we add the #greet method, we're able to invoke it