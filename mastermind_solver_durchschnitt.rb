require_relative 'mastermind_solver'

# Diese  Klasse ueberprueft in einer angemessenen Anzahl von Versuchen, wie oft der Computer das Spiel innerhalb von 10 Versuchen loest
# Author:: Uwe Krause
def durchschnittliche_versuche(anzahl)

  versuche_gesamt = []

  anzahl.times do

    @mastermind = Mastermind_Solver.new()

    versuche = 0

    while @mastermind.solved == false
      versuche += 1

      @mastermind.next_try()

    end

    versuche_gesamt << versuche if @mastermind.solved

  end

  versuche_gesamt

end

# Erweitert die Arrayklasse um nuetzliche Funktionen
class Array
  # call-seq:
  #   summe() => Float
  #
  # bildet die Summe
  def summe
    inject(0.0) { |result, el| result + el }
  end

  # call-seq:
  #   durchschnitt() => Float
  #
  # bildet den Durchschnitt
  def durchschnitt
    summe / size
  end
end

anzahl = 100
vs = durchschnittliche_versuche(anzahl)

puts "Bei #{anzahl} Versuchen loest der Algorithmus das Spiel in #{vs.durchschnitt} Versuchen."
puts "Hoechste Abzahl benoetigter Versuche: #{vs.max}"