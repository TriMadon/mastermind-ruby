# frozen_string_literal: true

require './feedback'
require './code'
require './player'

class ComputerPlayer < Player
  attr_reader :secret_code

  STARTING_GUESS = Code.new('1122')

  def initialize
    super
    @candidates = all_candidate_codes
    @last_guess = STARTING_GUESS
  end

  def create_code
    code = ''
    CODE_LENGTH.times { code += (rand * COLOR_VARIATIONS).ceil.to_s }
    @secret_code = Code.new(code)
  end

  def make_guess
    unless @feedback_list.empty?
      eliminate_invalid_candidates
      @last_guess = @candidates.shift
    end
    take_feedback(@last_guess)
    puts 'Computer is guessing...'
    sleep rand * 3 + 1
    @last_guess
  end

  def to_s
    'Computer'
  end

  private

  def all_candidate_codes
    (1111..6667).to_a.map { |code| Code.new(code.to_s) }.select(&:valid?)
  end

  def eliminate_invalid_candidates
    last_gss_arr = @last_guess.value.chars
    @candidates.select! do |candidate|
      cand_arr = candidate.value.chars
      feedback = Feedback.new(common_colors(cand_arr, last_gss_arr), identical_positions(cand_arr, last_gss_arr))
      feedback == @feedback_list.last[1]
    end
  end
end
