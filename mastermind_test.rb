require_relative 'mastermind_lucas'
require_relative 'mastermind_human_lucas'
require_relative 'mastermind_solver_third_try'
require 'test/unit'

#Author:: Lucas Anders
class MastermindTest < Test::Unit::TestCase
  def setup
    @mastermind = Mastermind.new()
    @human = Mastermind_Human.new()
    @solver = Mastermind_Solver.new()
  end

  def test_guesses
    assert(@mastermind.check_attempt([1,2,3,4]))
    assert(@mastermind.check_attempt([4,2,7,5]))
    assert(@mastermind.check_attempt([8,3,0,1]))
    assert_equal(false, @mastermind.check_attempt([1,1,1,1]))
    assert_equal(false, @mastermind.check_attempt([1,2,4,2]))
    assert_equal(false, @mastermind.check_attempt([10,3,5,7]))
    assert_equal(false, @mastermind.check_attempt(["a","b","c","d"]))
    assert_equal(false, @mastermind.check_attempt([1,2,3]))
  end

  def test_create_rand
    100.times do
    assert(@mastermind.check_attempt(@mastermind.create_rand()))
    end
  end
end