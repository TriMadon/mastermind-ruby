# frozen_string_literal: true

require './guess'

class HumanPlayer
  attr_reader :feedback_list

  def initialize
    @feedback_list = []
  end

  def make_guess
    loop do
      print "\nEnter your guess (e.g., 1234): "
      guess = Guess.new(gets.chomp.gsub(/\s+/, ''))

      return guess if guess.valid?

      puts 'Invalid input. Please enter a 4-digit guess using numbers 1 to 6.'
    end
  end

  def take_feedback(code_maker, guess)
    feedback = code_maker.give_feedback(guess)
    feedback_list.push [guess, feedback]
  end
end
