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
    losers.include?(other_move)
  end
end

class Rock < Move
  def losers
    ['lizard', 'scissors']
    # other_move == Lizard || other_move == Scissors
  end
end

class Paper < Move
  def losers
    ['rock', 'spock']
    # other_move == Rock || other_move == Spock
  end
end

class Scissors < Move
  def losers
    ['lizard', 'paper']
    # other_move == Lizard || other_move == Paper
  end
end

class Lizard < Move
  def losers
    ['spock', 'paper']
    # other_move == Spock || other_move == Paper
  end
end

class Spock < Move
  def losers
    ['rock', 'scissors']
    # other_move == Rock || other_move == Scissors
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
      break unless n.empty?
      puts "Please input some value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose: (r)ock, (p)aper, (s)cissors, (l)izard, or (sp)ock"
      choice = gets.chomp
      choice = refine_choice(choice) if Move::VALUES.include? choice
      break if Move::VALUES.include? choice
      puts "Please make a valid choice."
    end
    move_history << choice
    self.move = find_move(choice)
  end

  def refine_choice(str)
    return str if str.size > 3
    index = Move::VALUES.index(str)
    Move::VALUES[index - 5]
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D77', 'eyeRobot', 'BadCompi', 'Dude808', 'DeepMud'].sample
  end

  def probabilities
    case name
    when 'R2D77' then [(0..66), (67..69), (70..79), (80..89), (90..99)]
    when 'eyeRobot' then [(0..19), (20..39), (40..59), (60..79), (80..99)]
    when 'BadCompi' then [(0..0), (1..1), (2..2), (3..98), (99..99)]
    when 'Dude808' then  [(0..32), (33..65), (66..99), (100..100), (100..100)]
    when 'DeepMud' then [(0..0), (1..1), (2..2), (3..51), (52..99)]
    end
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
end

# Game Orchestration Engine
class RPSGame
  WINS = 3
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
    system "clear"
    m = "Hi #{human.name}, and welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts '-' * m.length
    puts m
    puts "The winner will be the first player to #{WINS} wins."
    puts "Your opponent this game is a robot named #{computer.name}. Good luck!"
    puts '-' * m.length
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def update_score
    if human.move > computer.move.value
      human.score += 1
    elsif computer.move > human.move.value
      computer.score += 1
    else
      human.ties += 1
    end
  end

  def display_winner
    if human.move > computer.move.value
      puts "#{human.name} won!"
    elsif computer.move > human.move.value
      puts "#{computer.name} won!"
    else
      puts "It's a tie."
    end
  end

  def display_score
    hs = human.score
    cs = computer.score
    ht = human.ties
    score = "SCOREBOARD #{human.name}: #{hs}, #{computer.name}: #{cs}, ties: #{ht}"
    puts "-" * score.length
    puts score
    puts "-" * score.length
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

  def clear_scores_history
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

  def display_history
    puts
    puts "History of moves:"
    size = human.move_history.size

    0.upto(size - 1) do |idx|
      hmove = human.move_history[idx]
      cmove = computer.move_history[idx]
      puts "#{human.name}: #{hmove.ljust(9)} #{computer.name}: #{cmove}"
    end
    puts
  end

  def display_goodbye_message
    positive = ['amazing', 'awesome', 'the best', 'great', 'a champ'].sample
    puts "Many thanks for playing. You are #{positive}! See ya!"
    puts
  end

  def play
    display_welcome_message
    loop do
      loop do
        sleep 1.2
        human.choose
        computer.choose
        sleep 0.3
        system "clear"
        display_moves
        update_score
        display_winner
        break if game_over?
        display_score
      end
      display_match_winner
      break unless play_again?
      clear_scores_history
    end
    display_history
    display_goodbye_message
  end
end

RPSGame.new.play
