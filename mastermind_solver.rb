require_relative 'mastermind'

# Der Computer spielt Mastermind auf dem Spielfeld
# Author:: Lucas Anders
# Author:: Uwe Krause
class Mastermind_Solver

  # Spiel gewonnen? true/false
  attr_reader :solved
  
  # call-seq:
  #   new() => Mastermind_Solver
  #
  # Generiert einen Computerspieler
  def initialize(sample = nil)

    # Spielfeld
    @mastermind = Mastermind.new(sample)

    # Holt die Regelvarianten vom Spielfeld
    @range = @mastermind.range # Erlaubter Wertebereich
    @digits = @mastermind.digits # Anzahl der Felder auf Spielfeld

    # zaehler / Zustandsvariablen
    @left = possible_guesses()
    @last_guess
    @last_hits
    @solved = false

    # Fuer Testzwecke
    @loesung = [1,2,3,4]
  end

  # call-seq:
  #   next_try() => an_array
  #
  # Generiert den naechsten Tipp, den der Computerspieler ans Spielfeld geben wird
  def next_try()
    if @last_guess == nil
      next_guess = @mastermind.create_rand()
    else
      next_guess = @left[rand(@left.length)]
    end

    @last_hits = @mastermind.try_attempt(next_guess)

    if @last_hits == [4,0]

      @solved = true
      times_tried = @mastermind.attempts

      return "#{next_guess}\n Game won in #{times_tried} tries!"

    end

    @last_guess = next_guess

    update_possible!()

    "#{next_guess} \n #{@mastermind.hits_to_s(@last_hits)}"
  end

  # call-seq:
  #   possible_guesses() => an_array
  #
  # erzeugt ein Array, das alle möglichen Tipps enthaelt
  def possible_guesses()

    possible = @range.to_a.permutation(@digits).to_a

  end

  # call-seq:
  #   update_possible() => nil
  #
  # loescht abhaengig von den letzten Hits und den Uebereinstimmungen zwischen zwei Tipps alle nicht moeglichen Tipps aus dem Array
  def update_possible!()

    #falls es keine Hits gibt, werden ale Tipps geloescht, die eine der Ziffern enthalten
    if (@last_hits == [0,0])
      @digits.times do |i|

        @left.delete_if{ |x|
          x.include?(@last_guess[i])
        }

      end

    end

    #falls es keine Black Hits gibt, werden alle Tipps mit einer identischen Stelle geloescht
    if @last_hits[0]==0

      @digits.times do |i|

        @left.delete_if { |x|
          x[i]==@last_guess[i]
        }
      end

    end

    #loescht alle, deren Uebereinstimmung mit dem letzten Tipp nicht den Black Hits entspricht
    @left.delete_if { |x|
      @last_hits[0] != @mastermind.hits(@last_guess,x)[0]
    }

    #loescht alle, deren Uebereinstimmung mit dem letzten Tipp nicht den Total Hits entspricht
    @left.delete_if { |x|
      (@last_hits[0] + @last_hits[1]) != (@mastermind.hits(@last_guess,x)[0]+@mastermind.hits(@last_guess,x)[1])
    }

  end

end