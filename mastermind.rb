# frozen_string_literal: true

require './computer_player'
require './human_player'
require 'io/console'

class Mastermind
  def initialize
    @maker = nil
    @breaker = nil
    @remaining_turns = 12
    @is_correct = false

    welcome_message
  end

  def start
    ask_if_human_wants_to_be_code_maker
    @breaker.create_code
    puts "\nLet's start!"
    main_loop
  end

  def main_loop
    until @remaining_turns.zero? || @maker.guess_matches?(@breaker.last_guess)
      puts "\nAttempts left: #{@remaining_turns}"
      print_previous_guesses
      make_guess
      @remaining_turns -= 1
      $stdout.clear_screen
    end

    @maker.guess_matches?(@breaker.last_guess) ? win_message : loss_message
  end

  private

  def welcome_message
    puts "Welcome to Mastermind!\n\n"
    puts 'Instructions:'
    puts '- Guess the 4-color secret code.'
    puts '- Colors are represented by numbers (1-6).'
    puts '- You have 12 attempts.'
    puts '- Feedback about the accuracy of your guess is provided after each guess.'
    puts '- You can choose being the code maker.'
  end

  def ask_if_human_wants_to_be_code_maker
    puts "\nDo you wish to be the code maker? y/n: "
    if gets.chomp.gsub(/\s+/, '').downcase == 'y'
      @maker = HumanPlayer.new
      @breaker = ComputerPlayer.new
    else
      @maker = ComputerPlayer.new
      @breaker = HumanPlayer.new
    end
  end

  def print_previous_guesses
    puts "\nPrevious guesses:"
    @breaker.feedback_list.each_with_index do |feedback, i|
      puts "#{i + 1}. #{feedback[0]}   #{feedback[1]}"
    end
  end

  def make_guess
    @breaker.take_feedback(@maker, @breaker.make_guess)
  end

  def win_message
    puts "\nYou have guessed the secret code correctly. Congratulations!"
  end

  def loss_message
    puts "\nYou have failed to guess the secret code within 12 turns"
  end
end
