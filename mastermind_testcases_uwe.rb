require 'Mastermind'
require 'test/unit'

class MastermindTestcases < Test::Unit::TestCase
  def setup()
    @mm = Mastermind.new()
  end
  
  def test_keine_treffer
    @mm.hi
  end
end