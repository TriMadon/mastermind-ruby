# frozen_string_literal: true

require './computer_player'
require './human_player'
require './guess'

class Mastermind
  def initialize
    @computer = ComputerPlayer.new
    @human = HumanPlayer.new
    @remaining_turns = 12
    @is_correct = false

    welcome_message
  end

  def start
    puts "\n Let's start!"
    main_loop
  end

  def main_loop
    until @remaining_turns.zero? || @is_correct == true
      puts "\nAttempts left: #{@remaining_turns}"
      print_previous_guesses
      guess = make_guess
      @human.take_feedback(@computer, guess)
      @is_correct = true if @computer.guess_matches?(guess)
      @remaining_turns -= 1
    end

    @is_correct ? win_message : loss_message
  end

  private

  def welcome_message
    puts "Welcome to Mastermind!\n\n"
    puts 'Instructions:'
    puts '- Guess the 4-color secret code.'
    puts '- Colors are represented by numbers (1-6).'
    puts '- You have 12 attempts.'
    puts '- Feedback about the accuracy of your guess is provided after each guess.'
  end

  def print_previous_guesses
    puts "\nPrevious guesses:"
    @human.feedback_list.each_with_index do |feedback, i|
      puts "#{i + 1}. #{feedback[0]}   #{feedback[1]}"
    end
  end

  def make_guess
    @human.make_guess
  end

  def win_message
    puts "\nYou have guessed the secret code correctly. Congratulations!"
  end

  def loss_message
    puts "\nYou have failed to guess the secret code within 12 turns"
  end
end
