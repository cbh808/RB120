=begin
Complete this program so that it produces the expected output:

class Book
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.

=end

class Book
  attr_reader :author, :title
  
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.) #call `to_s` on the instance `book`

=begin
Further1:
What are the differences between attr_reader, attr_writer, 
and attr_accessor? 
give access: read only, write only, or both read and write
Why did we use attr_reader instead of one of the other two? 
Would it be okay to use one of the others? 
Why or why not?
We used attr_reader because we needed only read access 
to the @author & @title instance variables.
We would only give write rights if we wanted instance variables
to be able to be reset from outside the class
=end

=begin
Further2:
Instead of attr_reader, suppose you had added the following 
methods to this class:
def title
    @title
  end
  
  def author
    @author
  end
Would this change the behavior of the class in any way?
If so, how? If not, why not?
output is same, but access rights have changed
Can you think of any advantages of this code?
would be able to chain methods to return values @title and @author
=end
 
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
  
  def title
    @title
  end
  
  def author
    @author
  end
end
puts
book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
puts book.author
