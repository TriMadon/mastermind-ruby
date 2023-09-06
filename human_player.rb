# frozen_string_literal: true

class HumanPlayer
  def initialize

  end

  def make_guess
    loop do
      print "\nEnter your guess (e.g., 1234): "
      guess = gets.chomp.gsub(/\s+/, '')

      return guess if guess.length == 4 && guess.match?(/^[1-6]+$/)

      puts 'Invalid input. Please enter a 4-digit guess using numbers 1 to 6.'
    end
  end
end
