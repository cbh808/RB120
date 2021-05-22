class GuessingGame
  RANGE = 1..200
  GUESSES = 7

  def initialize
    # good practice: init. instance variables in initialize even if not nec.
    @number = nil
  end

  def play
    loop do
      answer = nil
      guesses = GUESSES
      reset
      final_result(game_loop(guesses))
      break unless play_again?
    end
    bye
  end

  private

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
    @number = rand(RANGE)
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
    answer = nil
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      answer = gets.chomp.to_i
      return answer if RANGE.cover?(answer)
      puts "Invalid guess. Enter a number between 1 and 100: "
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
