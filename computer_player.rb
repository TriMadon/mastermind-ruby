# frozen_string_literal: true

require './feedback'

class ComputerPlayer
  CODE_LENGTH = 4
  COLOR_VARIATIONS = 6

  def initialize
    @secret_code = create_code
  end

  def create_code
    code = ''
    CODE_LENGTH.times { code += (rand * COLOR_VARIATIONS).ceil.to_s }
    code.chars
  end

  def give_feedback(guess)
    str = guess.value.chars

    # Calculate the number of correctly guessed colors and positions
    corr_colors = (@secret_code & str).flat_map { |n| [n] * [@secret_code.count(n), str.count(n)].min }.count
    corr_positions = @secret_code.zip(str).count { |item| item[0] == item[1] }

    Feedback.new(corr_colors, corr_positions)
  end

  def guess_matches?(guess)
    guess.value.chars == @secret_code
  end
end
