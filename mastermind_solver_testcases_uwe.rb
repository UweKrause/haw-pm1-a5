require 'mastermind_solver_uwe'
require 'test/unit'

# TODO: Testcases schreiben ^.^ 
class MastermindSolverTestcases < Test::Unit::TestCase
  def setup()
    @mm = Mastermind.new(1)
    @sample = @mm.sample
  end
end