class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +  # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +  # columns
                  [[1, 5, 9], [3, 5, 7]]               # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  # get array of unmarked keys
  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # return marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def check_for_two(marker)
    square = nil

    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, marker)
      break if square
    end

    square
  end

  def win_possible?(marker)
    check_for_two(marker)
  end

  def square5_open?
    unmarked_keys.include?(5)
  end

  private

  def find_at_risk_square(line, marker)
    if @squares.values_at(*line).map(&:marker).count(marker) == 2
      @squares.select { |k, v| line.include?(k) && v.unmarked? }.keys.first
    end
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_accessor :wins, :ties, :marker, :other_marker

  def initialize(marker1, marker2)
    @wins = 0
    @ties = 0
    @marker = marker1
    @other_marker = marker2
  end

  def increment_wins
    self.wins += 1
  end

  def increment_ties
    self.ties += 1
  end

  def reset
    self.wins = 0
    self.ties = 0
  end

  def won_match?
    wins == TTTGame.wins_to_win_match
  end
end

class Human < Player
  def move(board)
    puts "Please choose an empty square: #{joiner(board.unmarked_keys)}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice - choose well."
    end
    board[square] = marker
  end

  private

  def joiner(array, delimiter=', ', word='or')
    case array.size
    when 1 then array.first.to_s
    when 2 then "#{array.first} #{word} #{array.last}"
    else "#{array[0..-2].join(delimiter)} #{word} #{array.last}"
    end
  end
end

class Computer < Player
  def move(board)
    if board.win_possible?(marker) # offense
      square = board.check_for_two(marker)
    elsif board.win_possible?(other_marker) # defense
      square = board.check_for_two(other_marker)
    elsif board.square5_open? # take middle square
      square = 5
    else
      square = board.unmarked_keys.sample
    end

    board[square] = marker
  end
end

# orchestration engine
class TTTGame
  @@wins_to_win_match = 3
  @@marker1 = 'X'
  @@marker2 = 'O'

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new(@@marker1, @@marker2)
    @computer = Computer.new(@@marker2, @@marker1)
    @first_to_move = ''
    @current_marker = ''
  end

  def self.wins_to_win_match
    @@wins_to_win_match
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def play_game
    loop do
      current_player_moves
      clear_screen_and_display_board
      break if board.someone_won? || board.full?
    end
  end

  def increment_wins
    case board.winning_marker
    when human.marker
      human.increment_wins
    when computer.marker
      computer.increment_wins
    else
      human.increment_ties
    end
  end

  def match_over?
    human.wins == @@wins_to_win_match ||
      computer.wins == @@wins_to_win_match
  end

  def play_match
    loop do
      display_overall_score
      display_board
      play_game
      increment_wins
      display_result
      hit_any_key
      break if match_over?
      reset
    end
  end

  def main_game
    loop do
      determine_current_player
      play_match
      display_match_winner
      break unless play_again?
      reset
      reset_wins
      display_play_again_message
    end
  end

  def display_welcome_message
    puts "Hi there! Welcome to the TicTacToe experience!"
    puts "The first player to win #{@@wins_to_win_match} games wins the match."
    puts
  end

  def display_overall_score
    puts "Wins: #{human.wins}, Losses: #{computer.wins}, Ties:#{human.ties}"
  end

  def display_board
    puts ""
    puts "Your symbol is #{human.marker}. The Computer is #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end

  def prompt_first_player
    answer = nil
    loop do
      puts "Choose who goes first: 'X' (you) or 'O' (computer)"
      answer = gets.chomp.downcase
      break if ['x', 'o'].include?(answer)
      puts "Please input either 'X' or 'O'"
    end
    answer
  end

  def determine_current_player
    answer = prompt_first_player

    if answer == 'x'
      @current_marker = human.marker
      @first_to_move = human.marker
    else
      @current_marker = computer.marker
      @first_to_move = computer.marker
    end
    clear
  end

  def current_player_moves
    if human_turn?
      human.move(board)
      @current_marker = computer.marker
    else
      computer.move(board)
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_result
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "The computer won!"
    else
      puts "It's a tie."
    end
  end

  def hit_any_key
    puts ""
    puts "Hit any key to continue"
    gets.chomp
  end

  def display_match_winner
    if human.won_match?
      puts "You have #{@@wins_to_win_match} wins and have won the match!"
    else
      puts "The computer has #{@@wins_to_win_match} wins and has won the match!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Please input y or n"
    end

    answer == 'y'
  end

  def display_play_again_message
    puts "OK, so you wanna play again - let's do this."
    puts ''
  end

  def display_goodbye_message
    puts "Thank you so very much for playing."
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    @current_marker = @first_to_move
    clear
  end

  def reset_wins
    human.reset
    computer.reset
  end
end

game = TTTGame.new
game.play
