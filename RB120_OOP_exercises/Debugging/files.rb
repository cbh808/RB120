=begin
You started writing a very basic class for handling files. 
However, when you begin to write some simple test code, you get a NameError. 
The error message complains of an uninitialized constant File::FORMAT.
What is the problem and what are possible ways to fix it?
=end

class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post

# Discussion:
=begin
The FILE class doesn't have a FORMAT constant, and neither does any of its ancestor classes
Solutions:
1) designate the class that FORMAT constant is located, e.g.

def to_s
    "#{name}.#{self.class::FORMAT}"
  end

note that all classes are inheriting from `File` class and therefore able to access `to_s` method

2) exchange FORMAT in string interpolation to a method that retrieves correct constant, e.g.

class File
  # code omitted

  def to_s
    "#{name}.#{format}"  # calls the format method of the caller
  end
end

class MarkdownFile < File
  def format
    :md
  end
end

class VectorGraphicsFile < File
  def format
    :svg
  end
end

class MP3File < File
  def format
    :mp3
  end
end

# note above example of polymorphism, different object types
# responding differently to `format` method