module CliPaint
  class Controller
    def initialize
      @canvas = nil
    end

    def dispatch(command)
      case command[0]
      when 'Q'
        exit
      else
        puts "I don't know that command"
      end
    end
  end
end
