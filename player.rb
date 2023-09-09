# frozen_string_literal = true

class Player
  attr_reader :feedback_list, :last_guess

  CODE_LENGTH = 4
  COLOR_VARIATIONS = 6

  def initialize
    @feedback_list = []
    @last_guess = Code.new('0000')
    @secret_code = '0000'
  end

  def create_code
    raise 'Not implemented!'
  end

  def make_guess
    raise 'Not implemented!'
  end

  def give_feedback(guess)
    corr_colors = calculate_correct_colors(guess.value.chars)
    corr_positions = calculate_correct_positions(guess.value.chars)

    Feedback.new(corr_colors, corr_positions)
  end

  def guess_matches?(guess)
    guess == @secret_code
  end

  def take_feedback(code_maker, guess)
    feedback = code_maker.give_feedback(guess)
    feedback_list.push [guess, feedback]
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
