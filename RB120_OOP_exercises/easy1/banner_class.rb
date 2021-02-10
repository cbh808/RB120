=begin
Behold this incomplete class for constructing boxed banners.

Complete this class so that the test cases shown below work 
as intended. You are free to add any methods or instance 
variables you need. However, do not make the implementation 
details public.

You may assume that the input will always fit in your terminal 
window.

input: string as arg to new instance of Banner object 'banner'
output: banner printed to screen

Algorithm:
-initialize @message, @message_len
-adapt horizontal_rule, empty_line, and message_line with 
correct amount space as function of message length

=end

class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+#{'-'*(@message.length+2)}+"
  end

  def empty_line
    "|#{' '*(@message.length+2)}|"
  end

  def message_line
    "| #{@message} |"
  end
end



#Test Cases
banner = Banner.new('To boldly go where no one has gone before.')
puts banner
=begin
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
=end

banner = Banner.new('')
puts banner
=begin
+--+
|  |
|  |
|  |
+--+
=end
