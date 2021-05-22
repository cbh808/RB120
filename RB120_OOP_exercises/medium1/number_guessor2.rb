# Update to accept a low and high value when creating GuessingGame object
# use those values to compute a secret number for the game.
# change number of guesses so user can always win with good strategy

class GuessingGame
  def initialize
    # good practice: init. instance variables in initialize even if not nec.
    @number = nil
    @range_min = nil
    @range_max = nil
    @guesses = nil
    @size_of_range
  end

  def play
    set_range
    guesses = Math.log2(range_max-range_min).to_i + 1
    loop do
      answer = nil
      reset
      final_result(game_loop(guesses))
      break unless play_again?
    end
    bye
  end

  private

  attr_accessor :range_min, :range_max

  def game_loop(guesses)
    answer = nil
    while guesses > 0
      guesses_remaining(guesses)
      answer = enter_number
      display_current_result(answer)
      break if won?(answer)
      guesses -= 1
    end
    answer
  end

  def reset
    @number = rand(range_min..range_max)
  end

  def set_range
    puts
    puts "Please put in upper & lower bounds of the range."
    print "Range Minimum (number > 0): "
    min = gets.chomp.to_i
    min > 0 ? self.range_min = min : self.range_min = 1
    puts "minimum has been set to #{range_min}"
    puts
    @range_max =print "Range Maximum (number > min): "
    max = gets.chomp.to_i
    max > min ? self.range_max = max : self.range_max = range_min + rand(99..999)
    puts "maximum has been set to #{range_max}"
  end

  def guesses_remaining(guesses)
    puts
    if guesses == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{guesses} guesses remaining."
    end
  end

  def enter_number
    # answer = nil
    range = (range_min..range_max)
    loop do
      print "Enter a number between #{range_min} and #{range_max}: "
      answer = gets.chomp.to_i
      return answer if range.cover?(answer)
      puts "Invalid guess. Enter a number between #{range_min} and #{range_max}: "
    end
  end

  def display_current_result(answer)
    case answer
    when 1...@number then puts "Your guess is too low."
    when @number+1.. then puts "Your guess is too high."
    when @number then puts "That's the number!"
    end
  end

  def won?(answer)
    answer == @number
  end

  def final_result(answer)
    puts
    won?(answer) ? (puts 'You won!') : (puts 'You lost.')
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play play_again (y/n)?"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Please input 'y' or 'n'."
    end
    answer == 'y'
  end

  def bye
    puts "Bye Bye."
  end
end

game = GuessingGame.new
game.play