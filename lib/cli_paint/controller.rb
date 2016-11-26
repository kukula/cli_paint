module CliPaint
  class Controller
    GENERAL_ERR_MSG = "I don't know that command"
    NO_CANVAS_ERR_MSG = "You need to create canvas first"
    NUMBER_ARGS_ERR_MSG = "Wrong number of args for the command"
    ARGS_ERR_MSG = "Wrong args for the command"
    POINTS_ERR_MSG = "Points should be within the canvas"

    def initialize
      @canvas = nil
    end

    def dispatch(command)
      command = command.split(' ')
      case command[0]
      when 'C'
        create_canvas(command)
      when 'L'
        draw_line(command)
      when 'Q'
        exit
      else
        return GENERAL_ERR_MSG
      end
    end

    private

    def validate_number_of_args(command, number)
      return false unless command.size == number + 1
      true
    end

    def validate_all_integer(command)
      return false unless command[1..-1].all? { |arg| arg.to_i > 0 }
      true
    end

    def validate_canvas_exists
      return false if @canvas.nil?
      true
    end

    def validate_within_canvas(command)
      return false unless command[1..-1].map(&:to_i).
        each_slice(2).
        all? { |point| @canvas.valid?(*point) }
      true
    end

    def create_canvas(command)
      return NUMBER_ARGS_ERR_MSG unless validate_number_of_args(command, 2)
      return ARGS_ERR_MSG unless validate_all_integer(command)

      @canvas = Canvas.new(*command[1..2].map(&:to_i))
      @canvas.to_s
    end

    def draw_line(command)
      return NO_CANVAS_ERR_MSG unless validate_canvas_exists
      return NUMBER_ARGS_ERR_MSG unless validate_number_of_args(command, 4)
      return ARGS_ERR_MSG unless validate_all_integer(command)
      return POINTS_ERR_MSG unless validate_within_canvas(command)

      @canvas.line(*command[1..4].map(&:to_i))
      @canvas.to_s
    end
  end
end
