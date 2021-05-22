require 'set'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(string)
    @commands = string.split(' ')
    @register = 0
    @stack = []
  end

  def eval
    check_token

    while @commands.length > 0
      command = @commands.shift
      if is_string?(command)
        @register = command.to_i
      elsif command == 'PUSH'
        @stack << @register
      elsif command == 'PRINT'
        puts @register
      else
        raise EmptyStackError, "Empty stack!" if @stack.empty?
        case command
        when 'ADD'
          @register += @stack.pop
        when 'SUB'
          @register -= @stack.pop
        when 'MULT'
          @register *= @stack.pop
        when 'DIV'
          @register /= @stack.pop
        when 'MOD'
          @register %= @stack.pop
        when 'POP'
          @register = @stack.pop
        end
      end

    end
    @register
  end

  def is_string?(command)
    command.to_i.to_s == command
  end

  def check_token
    @commands.each do |token|
      next if is_string?(token)
      raise BadTokenError, "Invalid token: #{token}" if !ACTIONS.include?(token)
      end
    end
  end
end



Minilang.new('PRINT').eval
# 0
Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15
Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8
Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5
Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6
Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12
Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8
Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
puts
#Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB
Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!