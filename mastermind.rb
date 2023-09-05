# frozen_string_literal: true

require './computer_player'
require './human_player'

class Mastermind
  def initialize
    @comp_p = ComputerPlayer.new
    @human_p = HumanPlayer.new
    @secret_code = @comp_p.create_code

    welcome_message
  end

  def start
    puts "\n Let's start!"
    main_loop
  end

  def main_loop
    "To be implemented"
  end

  private

  def welcome_message
    puts "Welcome to Mastermind!\n\n"
    puts "Instructions:"
    puts "- Guess the 4-color secret code."
    puts "- Colors are represented by numbers (1-6)."
    puts "- You have 12 attempts."
    puts "- Feedback about the accuracy of your guess is provided after each guess."
  end
end
