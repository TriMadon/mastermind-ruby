# frozen_string_literal: true

require './code'
require './player'

class HumanPlayer < Player
  def create_code
    code = Code.new('0000')
    until code.valid?
      print "\nEnter your secret code (e.g., 1234): "
      code = Code.new(gets.chomp.gsub(/\s+/, ''))

      puts 'Invalid code. Please enter a 4-digit code using numbers (colors) 1 to 6.' unless code.valid?
    end
    @secret_code = code
  end

  def make_guess
    loop do
      print "\nEnter your guess (e.g., 1234): "
      @last_guess = Code.new(gets.chomp.gsub(/\s+/, ''))

      return @last_guess if @last_guess.valid?

      puts 'Invalid input. Please enter a 4-digit guess using numbers 1 to 6.'
    end
  end

  def to_s
    'Human'
  end
end
