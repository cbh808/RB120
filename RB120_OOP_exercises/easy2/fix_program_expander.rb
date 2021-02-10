=begin
Fix The Program - Expander
What is wrong with the following code? What fix(es) would you make?
=end

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3)          # remove although is possible since Ruby 2.7 
  end

  private   

  attr_reader :string  # add attr_reader

  def expand(n)
    string * n         # change @string to method string
  end
end

expander = Expander.new('xyz')
puts expander

#Note: prior to Ruby 2.7, private methods could never be called with an explicit caller, 
# even when that caller was `self`. Now possible with self

# As of Ruby 2.7, it is now legal to call private methods with a literal self as the caller.