=begin
Update this code so that when you run it, 
you see the following output:

My cat Pudding is 7 years old and has black and white fur.
My cat Butterscotch is 10 years old and has tan and white fur.
=end

# class Pet
#   def initialize(name, age)
#     @name = name
#     @age = age
#   end
# end

# class Cat < Pet
#   def initialize(name, age, fur_color)
#     super(name, age)
#     @fur_color = fur_color
#   end
  
#   def to_s
#     "My cat #{@name} is #{@age} years old and has #{@fur_color} fur."
#   end
# end

# pudding = Cat.new('Pudding', 7, 'black and white')
# butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
# puts pudding, butterscotch

=begin
Further Exploration

An alternative approach to this problem would be to modify 
the Pet class to accept a colors parameter. 
If we did this, we wouldn't need to supply an initialize 
method for Cat.

Why would we be able to omit the initialize method?
=> because initialize in class Pet is on the method lookup path.

Would it be a good idea to modify Pet in this way? Why or why not?
=> no, because not all pets have fur

How might you deal with some of the problems, 
if any, that might arise from modifying Pet?
=> could make an optional parameter in initialize method of Pet
=end

class Pet
  def initialize(name, age, fur_color=nil)
    @name = name
    @age = age
    @fur_color = fur_color
  end

  def to_s
    "My pet #{@name} is #{@age}"
  end
end

class Cat < Pet
  def to_s
    "My cat #{@name} is #{@age} years old and has #{@fur_color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

nemo = Pet.new('Nemo', 1)
puts nemo