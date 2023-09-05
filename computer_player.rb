# frozen_string_literal: true

class ComputerPlayer
  CODE_LENGTH = 4
  COLOR_VARIATIONS = 6

  def initialize

  end

  def create_code
    code = ''
    CODE_LENGTH.times { code += (rand * COLOR_VARIATIONS).ceil.to_s }
    code
  end
end
