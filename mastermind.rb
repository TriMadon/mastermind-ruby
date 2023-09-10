# frozen_string_literal: true

require './computer_player'
require './human_player'
require 'io/console'

class Mastermind
  def initialize
    @maker = nil
    @breaker = nil
    @remaining_turns = 12

    welcome_message
  end

  def start
    ask_if_human_wants_to_be_code_maker
    @breaker.intelligence = adjust_computer_intelligence if @breaker.is_a? ComputerPlayer
    @maker.create_code
    $stdout.clear_screen
    main_loop
  end

  def main_loop
    until @remaining_turns.zero? || @maker.guess_matches?(@breaker.last_guess)
      print_header
      print_previous_guesses unless @breaker.feedback_list.empty?
      make_guess
      @remaining_turns -= 1
      $stdout.clear_screen
    end

    @maker.guess_matches?(@breaker.last_guess) ? win_message : loss_message
    ask_retry
  end

  private

  def welcome_message
    puts '╔════════════════════════════════════════════════╗'
    puts '║                   Welcome to                   ║'
    puts '║                   Mastermind!                  ║'
    puts "╚════════════════════════════════════════════════╝\n\n"
    puts 'Instructions:'
    puts '- Guess the 4-color secret code.'
    puts '- Colors are represented by numbers (1-6).'
    puts '- You have 12 attempts.'
    puts '- Feedback about the accuracy of your guess is provided after each guess.'
    puts '- You can choose being the code maker.'
  end

  def ask_if_human_wants_to_be_code_maker
    puts "\nDo you wish to be the code maker? y/n: "
    if read_yes_or_no == 'y'
      @maker = HumanPlayer.new
      @breaker = ComputerPlayer.new
    else
      @maker = ComputerPlayer.new
      @breaker = HumanPlayer.new
    end
    @breaker.opponent = @maker
  end

  def adjust_computer_intelligence
    intel = nil
    while intel.to_i.negative? || intel.to_i > 10 || intel.nil?
      puts "\nPlease adjust the computer\'s intelligence level from 0 to 10 (10 being the highest):"
      begin
        intel = Integer(gets.chomp.gsub(/\s+/, ''))
      rescue ArgumentError
        puts "\nThat's not a valid input. Try again."
      end
    end
    intel
  end

  def print_header
    puts '╔════════════════════════════════════════════════╗'
    puts '║                   Mastermind                   ║'
    puts '╚════════════════════════════════════════════════╝'
    puts "\nAttempts left: #{@remaining_turns}"
  end

  def print_previous_guesses
    puts "\n──────────────────────────────────────────────────"
    puts 'Previous guesses:'
    @breaker.feedback_list.each_with_index do |feedback, i|
      puts "#{i + 1}. #{feedback[0]}   #{feedback[1]}"
    end
    puts '──────────────────────────────────────────────────'
  end

  def make_guess
    @breaker.make_guess
  end

  def win_message
    puts "\n#{@breaker} player has cracked the secret code. Congratulations!"
  end

  def loss_message
    puts "\n#{@breaker} player has failed to crack the secret code within 12 turns..."
    puts "\nThe secret code was: #{@maker.secret_code}" if @maker.is_a? ComputerPlayer
  end

  def ask_retry
    puts "\nDo you wish to retry? y/n: "
    if read_yes_or_no == 'y'
      @remaining_turns = 12
      start
    else
      puts "\nGame ends. Thank you for playing!"
    end
    @breaker.opponent = @maker
  end

  def read_yes_or_no
    gets.chomp.gsub(/\s+/, '').downcase
  end
end
