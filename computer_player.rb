# frozen_string_literal: true

require './feedback'
require './code'
require './player'

class ComputerPlayer < Player
  def create_code
    code = ''
    CODE_LENGTH.times { code += (rand * COLOR_VARIATIONS).ceil.to_s }
    @secret_code = Code.new(code)
  end

  def make_guess
    raise 'Not implemented!'
  end

  def to_s
    'Computer'
  end
end
