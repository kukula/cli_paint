module CliPaint
  class Canvas
    HORIZONTAL = '-'
    VERTICAL = '|'
    FILL = ' '
    LINE_FILL = 'x'
    NEIGHBORS = [-1, 0, 1].repeated_permutation(2).to_a

    attr_reader :width, :height, :pixels

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
      (0...width).cover?(x) &&
        (0...height).cover?(y)
    end

    def line(x1, y1, x2, y2)
      return unless (x1 == x2) ^ (y1 == y2)

      y1.upto(y2).each do |y|
        x1.upto(x2).each do |x|
          @pixels[y][x] = LINE_FILL
        end
      end
    end

    def rect(x1, y1, x2, y2)
      line(x1, y1, x2, y1)
      line(x1, y1, x1, y2)
      line(x1, y2, x2, y2)
      line(x2, y1, x2, y2)
    end

    def fill(x, y, fill)
      NEIGHBORS.each do |point|
        new_x = x + point[0]
        new_y = y + point[1]
        if valid?(new_x, new_y) && pixels[new_y][new_x] == FILL
          @pixels[new_y][new_x] = fill
          fill(new_x, new_y, fill)
        end
      end
    end

    private

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
