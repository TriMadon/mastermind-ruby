# frozen_string_literal: true

class Feedback
  attr_accessor :correct_colors, :correct_positions

  def initialize(corr_colors, corr_positions)
    @correct_colors = corr_colors
    @correct_positions = corr_positions
  end

  def ==(other)
    @correct_colors == other.correct_colors && @correct_positions == other.correct_positions
  end

  def to_s
    correct_colors_text = "#{@correct_colors} correct color"
    correct_colors_text += 's' if @correct_colors > 1

    correct_positions_text = "#{@correct_positions} correct position"
    correct_positions_text += 's' if @correct_positions > 1

    "[#{correct_colors_text}, #{correct_positions_text}]"
  end
end
