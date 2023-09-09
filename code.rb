# frozen_string_literal: true

class Code
  attr_reader :value

  def initialize(value)
    @value = value
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
