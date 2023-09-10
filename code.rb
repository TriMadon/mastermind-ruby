# frozen_string_literal: true

class Code
  attr_reader :value

  CODE_LENGTH = 4
  COLOR_VARIATIONS = 6

  def initialize(value)
    @value = value
  end

  def self.random
    code = ''
    CODE_LENGTH.times { code += (rand * COLOR_VARIATIONS).ceil.to_s }
    @secret_code = Code.new(code)
  end

  def valid?
    @value.length == 4 && @value.match?(/^[1-6]+$/)
  end

  def ==(other)
    @value == other.value
  end

  def to_s
    value.split('').join(' ')
  end
end
