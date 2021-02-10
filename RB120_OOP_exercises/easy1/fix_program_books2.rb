=begin
Complete this program so that it produces the expected output:
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
=end

class Book
  attr_accessor :author, :title

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Further Exploration
=begin
What do you think of this way of creating and initializing 
Book objects? (The two steps are separate.)
=> can imagine beneficial for use many cases due to increased flexibility

Would it be better to create and initialize at the same 
time like in the previous exercise? 
=> depends on use of data, flexibility required, importance of instance variable

What potential problems, if any, are introduced by separating the steps?
=> may never get data input for essential fields