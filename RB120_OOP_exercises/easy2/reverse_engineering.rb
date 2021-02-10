=begin
Write a class that will display:
ABC
xyz
when following run:
my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

=end

class Transform
  def initialize(str)
    @str = str
  end

  def uppercase
    @str.upcase
  end

  def self.lowercase(str)
    str.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

#Further Exploration
=begin
A class method is also, somewhat confusingly, called a "singleton method" 
(the term is used in other contexts as well). We don't recommend learning 
the details at this time - it may be more confusing than it is helpful - 
but you should be aware that you may encounter this term.
=end