# frozen_string_literal: true

require './code'

class HumanPlayer
  attr_reader :feedback_list, :last_guess

  def initialize
    @feedback_list = []
    @last_guess = Code.new('0000')
  end

  def make_guess
    loop do
      print "\nEnter your guess (e.g., 1234): "
      @last_guess = Code.new(gets.chomp.gsub(/\s+/, ''))

      return @last_guess if @last_guess.valid?

      puts 'Invalid input. Please enter a 4-digit guess using numbers 1 to 6.'
    end
  end

  def take_feedback(code_maker, guess)
    feedback = code_maker.give_feedback(guess)
    feedback_list.push [guess, feedback]
  end
end
