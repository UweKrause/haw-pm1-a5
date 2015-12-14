# Der Computer loest das Mastermind Raetsel
# Author:: Lucas Anders
# Author:: Uwe Krause

require_relative 'mastermind'

# Der Computer spielt Mastermind auf dem Spielfeld
class Mastermind_Solver
  # Fuer Script
  attr_reader :solved
  def initialize(sample = nil)
    @mastermind = Mastermind.new(sample)
    @left = possible_guesses()
    @last_guess
    @last_hits
    @loesung = [1,2,3,4]
    @solved = false
  end

  # generiert den nächsten Tipp
  def next_try
    if @last_guess == nil
      next_guess = @mastermind.create_rand()
    else
      next_guess = @left[rand(@left.length)]
    end
    @last_hits = @mastermind.try_attempt(next_guess)
    if @last_hits == [4,0]
      @solved = true
      return "#{next_guess} \n Game Won!"
    end
    @last_guess = next_guess
    update_possible
    return "#{next_guess} \n #{@mastermind.hits_to_s(@last_hits)}"
  end

  # erzeugt ein Array, das alle möglichen Tipps enthaelt
  def possible_guesses()
    range = (0..9)
    possible = range.to_a.permutation(4).to_a
    return possible
  end

  # loescht abhängig von den letzten Hits und den Übereinstimmungen zwischen zwei Tipps alle nicht möglichen Tipps aus dem Array
  def update_possible
    #falls es keine Hits gibt, werden ale Tipps geloescht, die eine der Ziffern enthalten
    if (@last_hits == [0,0])
      4.times do |i|
        @left.delete_if{|x| x.include?(@last_guess[i])}
      end
    end
    #falls es keine Black Hits gibt, werden alle Tipps mit einer identischen Stelle geloescht
    if @last_hits[0]==0
      4.times do |i|
        @left.delete_if{|x| x[i]==@last_guess[i]}
      end
    end
    #loescht alle, deren Uebereinstimmung mit dem letzten Tipp nicht den Black Hits entspricht
    @left.delete_if{|x| @last_hits[0] != @mastermind.hits(@last_guess,x)[0]}
    #loescht alle, deren Uebereinstimmung mit dem letzten Tipp nicht den Total Hits entspricht
    @left.delete_if{|x| (@last_hits[0] + @last_hits[1]) != (@mastermind.hits(@last_guess,x)[0]+@mastermind.hits(@last_guess,x)[1])}

  end

end