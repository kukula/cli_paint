module CliPaint
  class Controller
    GENERAL_ERR_MSG = "I don't know that command"
    CREATE_ERR_MSG = "Wrong args for create command"

    def initialize
      @canvas = nil
    end

    def dispatch(command)
      command = command.split(' ')
      case command[0]
      when 'C'
        create_canvas(command)
      when 'Q'
        exit
      else
        return GENERAL_ERR_MSG
      end
    end

    private

    def validate_create_canvas(command)
      return false unless
        command.size == 3 &&
        command[1].to_i > 0 &&
        command[2].to_i > 0

      true
    end

    def create_canvas(command)
      return CREATE_ERR_MSG unless validate_create_canvas(command)

      @canvas = Canvas.new(command[1].to_i, command[2].to_i)
      @canvas.to_s
    end
  end
end
