# frozen_string_literal: true

require './feedback'
require './code'
require './player'

class ComputerPlayer < Player
  attr_accessor :intelligence
  attr_reader :secret_code

  STARTING_GUESS = Code.new('1122')

  def initialize
    super
    @candidates = generate_candidate_codes
    @last_guess = STARTING_GUESS
    @intelligence = 10
  end

  def create_code
    @secret_code = Code.random
  end

  def make_guess
    if rand < @intelligence * 0.1 && !@feedback_list.empty?
      eliminate_invalid_candidates
      @last_guess = retrieve_guess_from_candidates
    else
      @last_guess = Code.random
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

  def generate_candidate_codes
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

  def retrieve_guess_from_candidates
    @candidates.length == 1 ? @candidates[0] : edit_based_on_intelligence(@candidates.shift)
  end

  def edit_based_on_intelligence(guess)
    gss = guess.value
    mutate_chance = 1 - (@intelligence * 0.1)

    if rand < mutate_chance
      changes = ((10 - @intelligence) * 0.4).ceil
      changes.times { mutate_random_position(gss) }
    end

    Code.new(gss)
  end

  def mutate_random_position(gss)
    position_to_mutate = (rand * Code::CODE_LENGTH).floor
    gss[position_to_mutate] = (rand * Code::COLOR_VARIATIONS).ceil.to_s
  end
end
