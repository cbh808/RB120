=begin
Now that we have a Walkable module, we are given a new challenge. 
Apparently some of our users are nobility, and the regular way 
of walking simply isn't good enough. Nobility need to strut.

We need a new class Noble that shows the title 
and name when walk is called:
byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"

We must have access to both name and title because they 
are needed for other purposes that we aren't showing here:
byron.name
=> "Byron"
byron.title
=> "Lord"
=end

# module Walkable
#   def walk
#     puts "#{self} #{gait} forward"
#   end
# end

# class Person
#   include Walkable
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     name
#   end

#   private

#   def gait
#     "strolls"
#   end
# end

# class Cat
#   include Walkable
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     name
#   end

#   private

#   def gait
#     "saunters"
#   end
# end

# class Cheetah
#   include Walkable
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     name
#   end

#   private

#   def gait
#     "runs"
#   end
# end

# class Noble
#   include Walkable
#   attr_reader :name, :title

#   def initialize(name, title)
#     @name = name
#     @title = title
#   end

#   def to_s
#     "#{title} #{name}"
#   end

#   private

#   def gait
#     "struts"
#   end
# end




# byron = Noble.new("Byron", "Lord")
# byron.walk
# # => "Lord Byron struts forward"

# p byron.name
# # => "Byron"
# p byron.title
# # => "Lord"

# Further Exploration 1
=begin
This exercise can be solved in a similar manner by using inheritance;
a Noble is a Person, and a Cheetah is a Cat, and both Persons and 
Cats are Animals. What changes would you need to make to this 
program to establish these relationships and eliminate the two 
duplicated `#to_s methods`?
=end

# module Walkable
#   def walk
#     puts "#{self} #{gait} forward"
#   end
# end

# class Person
#   include Walkable
#   attr_reader :name, :title

#   def initialize(name, title='')
#     @name = name
#     @title = title
#   end

#   def to_s
#     "#{title} #{name}".lstrip
#   end

#   private

#   def gait
#     "strolls"
#   end
# end

# class Cat
#   include Walkable
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     name
#   end

#   private

#   def gait
#     "saunters"
#   end
# end

# class Cheetah < Cat
#   include Walkable

#   private

#   def gait
#     "runs"
#   end
# end

# class Noble < Person
#   include Walkable

#   private

#   def gait
#     "struts"
#   end
# end

# mike = Person.new("Mike")
# mike.walk
# # => "Mike strolls forward"

# kitty = Cat.new("Kitty")
# kitty.walk
# # => "Kitty saunters forward"

# flash = Cheetah.new("Flash")
# flash.walk
# # => "Flash runs forward"
# puts
# byron = Noble.new("Byron", "Lord")
# byron.walk
# # => "Lord Byron struts forward"

# p byron.name
# # => "Byron"
# p byron.title
# # => "Lord"

# Further Exploration 2
=begin
Is to_s the best way to provide the name and title functionality 
we needed for this exercise? Might it be better to create either 
a different name method (or say a new full_name method) that 
automatically accesses @title and @name? There are tradeoffs with 
each choice -- they are worth considering.

A: create full_name method and add to module. 
Advantage: Less code, no to_s method.
Disadvantage: title may not be appropriate for Cat class, Cheetah Class, i.e.
extra instance variable to cover @title in each object even though will likely always be empty.
Give extra functionality to classes that don't need it
=end

module Walkable
  def walk
    puts "#{full_name} #{gait} forward"
  end
end

module FullName
  def full_name
    "#{title} #{name}".lstrip
  end
end

class Person
  include Walkable
  include FullName
  attr_reader :name, :title

  def initialize(name, title='')
    @name = name
    @title = title
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  include FullName
  attr_reader :name, :title

  def initialize(name, title='')
    @name = name
    @title = title
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah < Cat
  
  private

  def gait
    "runs"
  end
end

class Noble < Person

  private

  def gait
    "struts"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

mike = Person.new("Mike", "Mr.")
mike.walk
# => "Mr. Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

kitty = Cat.new("Kitty", "Queen")
kitty.walk
# => "Queen Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"
puts
byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"

p byron.name
# => "Byron"
p byron.title
# => "Lord"
