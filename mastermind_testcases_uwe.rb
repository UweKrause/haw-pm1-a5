require 'mastermind_uwe'
require 'test/unit'

class MastermindTestcases < Test::Unit::TestCase
  def setup()
    @mm = Mastermind.new("1234")
    @sample = @mm.sample
  end

  def test_erwartung_erfuellt?

    # gewonnen
    assert_equal("XXXX", @mm.hits("1234", @sample)[2])

    # keiner richtig
    assert_equal("____", @mm.hits("9999", @sample)[2])

    # paar schwarze, paar weisse, paar daneben
    assert_equal("XO__", @mm.hits("1122", @sample)[2])
    assert_equal("XX__", @mm.hits("2233", @sample)[2])
    assert_equal("XX__", @mm.hits("2244", @sample)[2])
    assert_equal("XO__", @mm.hits("2211", @sample)[2])
    assert_equal("XX__", @mm.hits("1331", @sample)[2])
    assert_equal("XX__", @mm.hits("4334", @sample)[2])
    assert_equal("OOOO", @mm.hits("2143", @sample)[2])
    assert_equal("XO__", @mm.hits("5814", @sample)[2])
    assert_equal("XXOO", @mm.hits("3214", @sample)[2])
    assert_equal("XXX_", @mm.hits("1231", @sample)[2])
    assert_equal("XXX_", @mm.hits("1239", @sample)[2])
    assert_equal("XXO_", @mm.hits("1293", @sample)[2])
    assert_equal("X___", @mm.hits("1111", @sample)[2])
    assert_equal("X___", @mm.hits("2222", "1234")[2])
  end

  def test_fehlerhafte_uebergabe
    assert_raise RangeError do
      @mm.hits("")
    end
    assert_raise ArgumentError do
      @mm.hits()
    end
  end
end