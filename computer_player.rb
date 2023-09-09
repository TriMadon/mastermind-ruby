# frozen_string_literal: true

require './feedback'
require './code'

class ComputerPlayer
  CODE_LENGTH = 4
  COLOR_VARIATIONS = 6

  def initialize
    @secret_code = create_code
  end

  def create_code
    code = ''
    CODE_LENGTH.times { code += (rand * COLOR_VARIATIONS).ceil.to_s }
    Code.new(code)
  end

  def give_feedback(guess)
    corr_colors = calculate_correct_colors(guess.value.chars)
    corr_positions = calculate_correct_positions(guess.value.chars)

    Feedback.new(corr_colors, corr_positions)
  end

  def guess_matches?(guess)
    guess == @secret_code
  end

  private

  def calculate_correct_colors(gss)
    sec = @secret_code.value.chars
    (sec & gss).flat_map { |n| [n] * [sec.count(n), gss.count(n)].min }.count
  end

  def calculate_correct_positions(gss)
    sec = @secret_code.value.chars
    sec.zip(gss).count { |item| item[0] == item[1] }
  end
end
