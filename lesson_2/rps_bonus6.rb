class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock',
            'r', 'p', 's', 'l', 'sp']

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def >(other_move)
    losers.include?(other_move.class)
  end
end

class Rock < Move
  private

  def losers
    [Lizard, Scissors]
  end
end

class Paper < Move
  private

  def losers
    [Rock, Spock]
  end
end

class Scissors < Move
  private

  def losers
    [Lizard, Paper]
  end
end

class Lizard < Move
  private

  def losers
    [Spock, Paper]
  end
end

class Spock < Move
  private

  def losers
    [Rock, Scissors]
  end
end

class Player
  attr_accessor :move, :name, :score, :ties, :move_history

  def initialize
    set_name
    @score = 0
    @ties = 0
    @move_history = []
  end

  private

  def find_move(choice)
    case choice
    when 'rock' then Rock.new(choice)
    when 'paper' then Paper.new(choice)
    when 'scissors' then Scissors.new(choice)
    when 'lizard' then Lizard.new(choice)
    when 'spock' then Spock.new(choice)
    end
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "Please input your name!"
      n = gets.chomp
      break unless n.split.join.empty?
      puts "Please input some value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose: (r)ock, (p)aper, (s)cissors, (l)izard, or (sp)ock"
      choice = refine_choice(gets.chomp)
      break if valid_choice?(choice)
      puts "Please make a valid choice."
    end
    move_history << choice
    self.move = find_move(choice)
  end

  private

  def valid_choice?(choice)
    Move::VALUES.include? choice
  end

  def refine_choice(choice)
    if valid_choice?(choice)
      return choice if choice.size > 3
      index = Move::VALUES.index(choice)
      Move::VALUES[index - 5]
    else
      choice
    end
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D77', 'eyeRobot', 'BadCompi', 'Dude808', 'DeepMud'].sample
  end

  def choose
    random = rand(100)
    choice = nil

    probabilities.each_with_index do |range, idx|
      choice = Move::VALUES[idx] if range.include?(random)
    end

    self.move = find_move(choice)
    move_history << choice
  end

  private

  def probabilities
    # ranges representing probabilities for each move in order [r, p, s, l, sp]
    case name
    when 'R2D77' then [(0..66), (67..69), (70..79), (80..89), (90..99)]
    when 'eyeRobot' then [(0..19), (20..39), (40..59), (60..79), (80..99)]
    when 'BadCompi' then [(0..0), (1..1), (2..2), (3..98), (99..99)]
    when 'Dude808' then  [(0..32), (33..65), (66..99), (100..100), (100..100)]
    when 'DeepMud' then [(0..0), (1..1), (2..2), (3..51), (52..99)]
    end
  end
end

# Game Orchestration Engine
class RPSGame
  WINS = 3

  def play
    display_welcome_message
    play_framework
    display_history
    display_goodbye_message
  end

  private

  attr_accessor :human, :computer

  def initialize
    system "clear"
    display_wisdom
    @human = Human.new
    @computer = Computer.new
  end

  def display_wisdom
    puts "----------------------------------------"
    puts '        A wise robot once said:        '
    puts
    puts '"Scissors cuts Paper covers Rock crushes'
    puts 'Lizard poisons Spock smashes Scissors'
    puts 'decapitates Lizard eats Paper disproves'
    puts 'Spock vaporizes Rock crushes Scissors"'
    puts "----------------------------------------"
    puts
  end

  def display_welcome_message
    m = "Hi #{human.name}, and welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts '-' * m.length
    puts m
    puts
    puts "The winner will be the first player to #{WINS} wins."
    puts "Your opponent is a robot named #{computer.name}. Good luck!"
    puts '-' * m.length
    hit_key
  end

  def display_moves
    sleep 0.5
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def update_score
    if human.move > computer.move
      human.score += 1
    elsif computer.move > human.move
      computer.score += 1
    else
      human.ties += 1
    end
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif computer.move > human.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie."
    end
    hit_key
  end

  def hit_key
    puts "hit enter to continue"
    gets.chomp
  end

  def scoreboard
    hs = human.score
    cs = computer.score
    ht = human.ties
    "SCORE => #{human.name}: #{hs}, #{computer.name}: #{cs}, ties: #{ht}"
  end

  def display_score
    system "clear"
    puts "-" * scoreboard.length
    puts scoreboard
    puts "-" * scoreboard.length
  end

  def display_match_winner
    puts "#{final_winner} won #{WINS} games and is the winner!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "invalid input, please input 'y' or 'n'"
    end

    return false if answer == 'n'
    return true if answer == 'y'
  end

  def clear_scores
    human.score = 0
    computer.score = 0
    human.ties = 0
  end

  def game_over?
    human.score == WINS || computer.score == WINS
  end

  def final_winner
    human.score == WINS ? human.name : computer.name
  end

  def historic_moves
    0.upto(human.move_history.size - 1) do |idx|
      hmove = human.move_history[idx]
      cmove = computer.move_history[idx]
      puts "#{human.name}: #{hmove.ljust(9)} #{computer.name}: #{cmove}"
    end
  end

  def display_history
    puts
    puts "History of moves:"
    puts "--------------------------------"
    historic_moves
  end

  def display_goodbye_message
    positive = ['amazing', 'awesome', 'the best', 'great', 'a champ'].sample
    puts
    puts "Many thanks for playing. You are #{positive}! See ya!"
    puts
  end

  def play_framework
    loop do
      game_loop
      system 'clear'
      display_match_winner
      break unless play_again?
      clear_scores
    end
  end

  def game_loop
    loop do
      display_score
      display_wisdom
      human.choose
      computer.choose
      display_moves
      update_score
      display_winner
      break if game_over?
    end
  end
end

RPSGame.new.play
