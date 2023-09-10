# frozen_string_literal: true

class Player
  attr_accessor :opponent
  attr_reader :feedback_list, :last_guess

  def initialize
    @feedback_list = []
    @last_guess = Code.new('0000')
    @secret_code = Code.new('0000')
    @opponent = nil
  end

  def create_code
    raise 'Not implemented!'
  end

  def make_guess
    raise 'Not implemented!'
  end

  def give_feedback(guess)
    gss_arr = guess.value.chars
    sec_arr = @secret_code.value.chars
    corr_colors = common_colors(gss_arr, sec_arr)
    corr_positions = identical_positions(gss_arr, sec_arr)

    Feedback.new(corr_colors, corr_positions)
  end

  def guess_matches?(guess)
    guess == @secret_code
  end

  def take_feedback(guess)
    feedback = @opponent.give_feedback(guess)
    feedback_list.push [guess, feedback]
  end

  protected

  def common_colors(gss_arr, sec_arr)
    (sec_arr & gss_arr).flat_map { |n| [n] * [sec_arr.count(n), gss_arr.count(n)].min }.count
  end

  def identical_positions(gss_arr, sec_arr)
    sec_arr.zip(gss_arr).count { |item| item[0] == item[1] }
  end
end
