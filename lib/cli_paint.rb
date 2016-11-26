require "cli_paint/version"
require "cli_paint/canvas"
require "cli_paint/controller"

module CliPaint
  def self.run!
    controller = Controller.new
    loop do
      puts 'enter command:'
      puts controller.dispatch($stdin.gets.chomp)
    end
  end
end
