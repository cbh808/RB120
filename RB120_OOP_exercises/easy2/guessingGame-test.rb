class GuessingGame
  def initialize
    @guesses = 7
    @correct_answer = (1..100).to_a.sample
    @answer = nil
  end
  def play
    loop do
      user_prompt
      number_validation
      return display_loss if guesses == 0
      break if answer == @correct_answer
    end
    display_victory
  end
  private
  attr_accessor :guesses, :answer
  def user_prompt
    loop do
      puts "You have #{guesses} guesses remaining."
      puts "Enter a number between 1 and 100: "
      self.answer = gets.chomp.to_f
      break if (1..100).include?(self.answer.to_i) && self.answer == self.answer.to_i
      puts "That's not a valid answer - please enter a whole number between 1 and 100."
    end
    self.answer = self.answer.to_i
    self.guesses -= 1
  end
  def number_validation
    if answer < @correct_answer
      puts "Your guess is too low."
    elsif answer > @correct_answer
      puts "Your guess is too high."
    else
      puts "That's correct!"
    end
  end
  def display_victory
    puts "You won!"
  end
  def display_loss
    puts "You have no more guesses. You lost!"
    puts "The correct number was #{@correct_answer}."
  end
end
GuessingGame.new.play