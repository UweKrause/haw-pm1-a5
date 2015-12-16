# Erweitert die ExceptionClass
# Author:: Lucas Anders
class GameOver < StandardError
  def initialize(info = nil)
    @info = info
  end
end