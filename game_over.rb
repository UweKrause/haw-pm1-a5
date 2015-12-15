class GameOver < StandardError
  def initialize(info = nil)
    @info = info
  end
#  def message
#    
#  end
end