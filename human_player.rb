# frozen_string_literal: true

class HumanPlayer
  def initialize

  end

  def make_guess
    puts "\nEnter your guess (e.g., 1234):"
    gets.chomp.gsub(/[[:space:]]/, '')
  end
end
