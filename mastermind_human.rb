require_relative 'mastermind'

# Spielt Mastermind Mensch gegen Maschine<br>
# Die Klasse uebergibt die Eingaben des Nutzers an das Spielfeld
# Author:: Lucas Anders
# Author:: Uwe Krause
class Mastermind_Human

  # Spiel gewonnen? true/false
  attr_reader :solved
  
  # Ein Mensch wird geboren
  def initialize
    # Das Spielfeld
    @mastermind = Mastermind.new()

    # Holt die Regelvarianten vom Spielfeld
    @digits = @mastermind.digits # Anzahl der Felder auf Spielfeld

    # Status des Spiels
    @solved = false
  end

  # call-seq:
  #   next_try() => str
  #
  # Liest den naechsten Tipp ein und uebergibt diesen an den Computer<br>
  # Liefert dem Nutzer Feedback, wieviele Treffer
  def next_try()

    hits = @mastermind.try_attempt(get_input())

    if hits == [@digits,0]

      @solved = true
      times_tried = @mastermind.attempts

      return returnstring = "#{@mastermind.hits_to_s(hits)}\n Game won in #{times_tried} tries!"

    end

    @mastermind.hits_to_s(hits)

  end

end