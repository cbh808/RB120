=begin
Modify the House class so that the above program will work. 
You are permitted to define only one new method in House.
=end

class House
  attr_reader :price
  include Comparable

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end

end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

#Further Exploration
=begin
Is the technique we employ here to make House objects comparable 
a good one? (Hint: is there a natural way to compare Houses? 
=> it would be easier to compare the instance variables directly.
Is price the only criteria you might use?)
=> no you could evaluate location, taxes, schools, etc. 
What problems might you run into, if any? 
=> all evaluations need to be numerical and weighted to get a comparable value
Can you think of any sort of classes where including Comparable is a good idea?
=> integers, sizes of strings, strings
=end