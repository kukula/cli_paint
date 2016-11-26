module CliPaint
  class Controller
    GENERAL_ERR_MSG = "I don't know that command"
    NO_CANVAS_ERR_MSG = "You need to create canvas first"
    ARGS_ERR_MSG = "Wrong args for command"

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

    def validate_args(command, number)
      return false unless
        command.size == number + 1 &&
          command[1..number + 1].all? { |arg| arg.to_i > 0 }

      true
    end

    def validate_canvas_exists
      return false if @canvas.nil?
      true
    end

    def create_canvas(command)
      return ARGS_ERR_MSG unless validate_args(command, 2)

      @canvas = Canvas.new(*command[1..2].map(&:to_i))
      @canvas.to_s
    end

    def draw_line(command)
      return NO_CANVAS_ERR_MSG unless validate_canvas_exists
      return ARGS_ERR_MSG unless validate_args(command, 4)

      @canvas.line(*command[1..4].map(&:to_i))
      @canvas.to_s
    end
  end
end
