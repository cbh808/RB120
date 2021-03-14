module Playable
  def hit(deck)
    puts "#{name} decided to hit."
    sleep 1.33
    deck.deal_card(self)
  end
end

class Cards
  SUIT = ['H', 'C', 'D', 'S']
  FACE = %w(2 3 4 5 6 7 8 9 10 J K Q A)

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "The #{face} of #{suit}"
  end

  def face
    case @face
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else
      @face
    end
  end

  def suit
    case @suit
    when 'H' then 'Hearts'
    when 'D' then 'Diamonds'
    when 'S' then 'Spades'
    when 'C' then 'Clubs'
    end
  end

  def ace?
    face == 'Ace'
  end

  def king?
    face == 'King'
  end

  def queen?
    face == 'Queen'
  end

  def jack?
    face == 'Jack'
  end
end

class Participant
  include Playable

  attr_reader :total, :name
  attr_accessor :hand

  def initialize
    @hand = []
    @total = 0
  end

  def show_hand
    puts "---- #{name} Hand ----"
    hand.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{hand_total}"
    puts ""
  end

  def hand_total
    maximum + correct_for_aces(maximum)
  end

  def maximum
    max = 0

    hand.each do |card|
      max += if card.ace?
               11
             elsif card.jack? || card.queen? || card.king?
               10
             else
               card.face.to_i
             end
    end
    max
  end

  def correct_for_aces(max)
    correction = 0
    hand.select(&:ace?).count.times do
      break if max <= 21
      correction -= 10
      max -= correction
    end

    correction
  end

  def busted?
    hand_total > 21
  end
end

class Player < Participant
  def initialize
    super
    @name = "You"
  end

  def play(deck)
    loop do
      if hit?(hit_or_stay?)
        hit(deck)
        show_hand.to_s
      else
        puts "#{name} decided to stay."
        break
      end
      break if busted?
    end
  end
end

def hit_or_stay?
  answer = ''
  loop do
    puts "Would you like to (h)it or (s)tay?"
    answer = gets.chomp.downcase
    break if ['h', 's'].include?(answer)
    puts "please choose 'h' or 's'."
  end
  answer
end

def hit?(answer)
  answer == 'h'
end

class Dealer < Participant
  include Playable

  def initialize
    super
    @name = "Dealer"
  end

  def play(deck)
    loop do
      break if busted?
      if hand_total >= 17
        puts "#{name} has stayed."
        break
      else
        hit(deck)
        show_last_card.to_s
      end
    end
  end

  def show_first_card
    puts "---- #{name} Hand ----"
    puts "=> #{hand.first}"
    puts "=> 2nd card down"
    puts ""
  end

  def show_last_card
    puts "=> #{hand.last}"
    puts "=> Total: #{hand_total}"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Cards::SUIT.each do |suit|
      Cards::FACE.each do |face|
        @cards << Cards.new(suit, face)
      end
    end
  end

  def deal(player, dealer)
    shuffle
    2.times do
      deal_card(player)
      deal_card(dealer)
    end
  end

  def shuffle
    self.cards = cards.shuffle!
  end

  def deal_card(reciever)
    reciever.hand << cards.pop
  end
end

class Game
  attr_reader :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def reset
    self.deck = Deck.new if deck.cards.size < 12
    player.hand = []
    dealer.hand = []
  end

  def start
    loop do
      welcome_message
      deal_cards
      show_initial_cards
      players_play
      show_result
      play_again? ? reset : break
    end
    goodbye
  end

  def welcome_message
    system 'clear'
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "Welcome to 21. It's sorta like blackjack."
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  end

  def deal_cards
    deck.deal(player, dealer)
  end

  def players_play
    player.play(deck)
    return if player.busted?
    dealer.show_hand.to_s
    dealer.play(deck)
  end

  def show_initial_cards
    player.show_hand.to_s
    dealer.show_first_card.to_s
  end

  def show_result
    if player.busted?
      puts "You busted. The dealer wins!"
    elsif dealer.busted?
      puts "The #{dealer.name} busted. You be winning yeah!"
    elsif player.hand_total != dealer.hand_total
      declare_winner
    else
      puts "It's a tie! #{player.hand_total} all."
    end
  end

  def declare_winner
    if player.hand_total > dealer.hand_total
      puts "You won! #{player.hand_total} to #{dealer.hand_total}"
    else
      puts "You lost! #{dealer.hand_total} to #{player.hand_total}"
    end
  end

  def play_again?
    answer = ''
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Please choose 'y' or 'n'."
    end
    answer == 'y'
  end

  def goodbye
    puts ""
    puts "Live it - Love it! Goodbye!"
  end
end

Game.new.start
