require_relative 'mastermind'
require_relative 'mastermind_human'
require_relative 'mastermind_solver'
require 'test/unit'

# Definiert Testfaelle fuer das Spielfeld
# Author:: Lucas Anders

class Mastermind_Test < Test::Unit::TestCase
  # Definiert das Testbett
  def setup
    @mastermind = Mastermind.new([1,2,3,4])
    @attempts_max = @mastermind.attempts_max
  end

  # Prueft, ob gueltige Versuche von ungueltigen Anfragen korrekt unterschieden werden
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

  # Testet, ob der zufaellige Wert korrekt generiert wird
  def test_create_rand
    100.times do
      assert(@mastermind.check_attempt(@mastermind.create_rand()))
    end
  end

  # Testet, ob vorgegebene Versuche den erwarteten Rueckgabewert liefern
  def test_hits
    assert_equal([4,0], @mastermind.hits([1,2,3,4]))
    assert_equal([3,0], @mastermind.hits([1,2,3,6]))
    assert_equal([2,0], @mastermind.hits([1,2,5,9]))
    assert_equal([1,0], @mastermind.hits([1,6,7,8]))
    assert_equal([2,2], @mastermind.hits([1,2,4,3]))
    assert_equal([2,1], @mastermind.hits([1,2,4,8]))
    assert_equal([1,3], @mastermind.hits([1,4,2,3]))
    assert_equal([0,4], @mastermind.hits([4,3,2,1]))
    assert_equal([0,2], @mastermind.hits([9,3,7,1]))
  end

  # Testet, ob das Spiel nach der Festgelegten Anzahl von Versuchen abgebrochen wird
  def test_guess_limit
    assert_raise do
      (@attempts_max+1).times do @mastermind.try_attempt([3,6,8,5])
      end
    end
  end
end