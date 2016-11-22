module CliPaint
  class Canvas
    HORIZONTAL = '-'
    VERTICAL = '|'
    FILL = ' '

    def initialize(width, height)
      @width = width
      @height = height
      @pixels = Array.new(height) { Array.new(width, FILL) }
    end

    def to_s
      [
        horizontal_border,
        canvas_with_vertical_borders,
        horizontal_border
      ].join("\n")
    end

    def valid?(x, y)
      (0..width).cover?(x) &&
        (0..height).cover?(y)
    end

    private

    attr_reader :width, :height, :pixels

    def horizontal_border
      HORIZONTAL * (width + 2)
    end

    def canvas_with_vertical_borders
      pixels.map do |row|
        VERTICAL + row.join + VERTICAL
      end.join("\n")
    end
  end
end
