module CliPaint
  class Controller
    GENERAL_ERR_MSG = "I don't know that command"
    NO_CANVAS_ERR_MSG = "You need to create canvas first"
    NUMBER_ARGS_ERR_MSG = "Wrong number of args for the command"
    ARGS_ERR_MSG = "Wrong args for the command"
    POINTS_ERR_MSG = "Points should be within the canvas"
    LINE_ERR_MSG = "Lines can be horizontal or vertical only"
    TOP_LEFT_ERR_MSG = "Top-left point first"

    def initialize
      @canvas = nil
    end

    def dispatch(command_string)
      command, *args = command_string.split(' ')

      case command
      when 'C'
        create_canvas(args)
      when 'L'
        draw_line(args)
      when 'R'
        draw_rect(args)
      when 'B'
        bucket_fill(args)
      when 'Q'
        exit
      else
        return GENERAL_ERR_MSG
      end
    end

    private

    def validate_all_integer(args)
      return false unless args.all? { |arg| arg.to_i > 0 }
      true
    end

    def validate_canvas_exists
      return false if @canvas.nil?
      true
    end

    def validate_within_canvas(args)
      return false unless args.map(&:to_i).each_slice(2).
        all? { |point| @canvas.valid?(*point) }
      true
    end

    def validate_line(args)
      x1, y1, x2, y2 = *args
      return false unless (x1 == x2) ^ (y1 == y2)
      true
    end

    def validate_top_left(args)
      x1, y1, x2, y2 = *args
      return false unless (x1 <= x2) && (y1 <= y2)
      true
    end

    def create_canvas(args)
      return NUMBER_ARGS_ERR_MSG unless args.size == 2
      return ARGS_ERR_MSG unless validate_all_integer(args)

      @canvas = Canvas.new(*args.map(&:to_i))
      @canvas.to_s
    end

    def draw_line(args)
      return NO_CANVAS_ERR_MSG unless validate_canvas_exists
      return NUMBER_ARGS_ERR_MSG unless args.size == 4
      return ARGS_ERR_MSG unless validate_all_integer(args)
      return POINTS_ERR_MSG unless validate_within_canvas(args)
      return LINE_ERR_MSG unless validate_line(args)
      return TOP_LEFT_ERR_MSG unless validate_top_left(args)

      @canvas.line(*args.map(&:to_i))
      @canvas.to_s
    end

    def draw_rect(args)
      return NO_CANVAS_ERR_MSG unless validate_canvas_exists
      return NUMBER_ARGS_ERR_MSG unless args.size == 4
      return ARGS_ERR_MSG unless validate_all_integer(args)
      return POINTS_ERR_MSG unless validate_within_canvas(args)
      return TOP_LEFT_ERR_MSG unless validate_top_left(args)

      @canvas.rect(*args.map(&:to_i))
      @canvas.to_s
    end

    def bucket_fill(args)
      return NO_CANVAS_ERR_MSG unless validate_canvas_exists
      return NUMBER_ARGS_ERR_MSG unless args.size == 3
      x, y, fill = *args
      return POINTS_ERR_MSG unless validate_within_canvas([x, y])

      @canvas.fill(x.to_i, y.to_i, fill[0])
      @canvas.to_s
    end
  end
end
