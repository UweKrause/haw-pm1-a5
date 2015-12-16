require_relative 'game_over'

# Die Mastermind-Klasse stellt das Spielfeld dar.<br>
# Attribute sind gleichzeitig die Regeln des Spiels:<br>
# Anzahl der Felder auf dem Spielfeld,<br>
# Anzahl der erlaubten Versuche,<br>
# Zahlraum der Moeglichkeiten ("Farben")
# Author:: Lucas Anders
# Author:: Uwe krause
class Mastermind
  # Fuer Debugging / Testfaelle
  attr_reader :sample

  # Stellt dem Spieler die Spielregelvariablen zur Verfuegung
  attr_reader :digits, :attempts_max, :range

  # Stellt dem Spieler die Anzahl der bereits verbrauchten Versuche zur Verfuegung
  attr_reader :attempts
  # call-seq:
  #   new([sample]) => Mastermind
  #
  # Generiert das Spielfeld.<br>
  # Wenn mit (gueltigem) seed-Parameter aufgerufen, wird ein zu erratener Code festgelegt,<br>
  # ansonsten wird einer generiert
  def initialize(sample = nil)
    # Spielregelvariablen hier:
    @digits = 4 # Anzahl der Felder auf Spielfeld
    @attempts_max = 10 # Anzahl der erlaubten
    @range = (0..9)
    @sample = create_rand(sample)

    # Sonstige Instanzvariablen
    @attempts = 0
  end

  # call-seq:
  #   try_attempt(guess) => an_array
  #
  # Ein Spielzug des Spielers.<br>
  # Verbraucht einen Spielzug,<br>
  # liefert die Anzahl der Treffer zurueck
  def try_attempt(guess)
    raise ArgumentError unless check_attempt(guess)
    raise GameOver if @attempts >= @attempts_max

    @attempts += 1
    return hits(guess)
  end

  # call-seq:
  #   check_attempt(guess) => true or false
  #
  # Ueberprueft uebergebene Parameter auf Gueltigkeit
  def check_attempt(guess)
    return false unless (guess.is_a?(Array) && guess.length == 4)
    return false if guess.uniq != guess
    guess.each do |x|
      return false if !((0..9).include?(x))
    end
    return true
  end

  # call-seq:
  #   create_rand([sample]) => an_array
  #
  # Erzeugt einen zufaelligen Tipp, wenn kein Vorgabewert
  def create_rand(sample = nil)

    return @range.to_a.sample(@digits) if sample.nil?

    raise ArgumentError unless check_attempt(sample)
    #else return
    sample

  end

  # call-seq:
  #   hits(tipp, [sample]) => an_array
  #
  # Ermittelt die korrekte Zahl von schwarzen und weissen Treffern.<br>
  # Gibt Array zurueck [int Schwarz, int Weiss, str String]<br>
  # Wenn optionaler Parameter sample uebergeben, prueft ersten Parameter gegen zweiten
  def hits(tipp, sample = @sample)
    white_hits = 0
    black_hits = 0

    @digits.times do |i|
      black_hits += 1 if tipp[i] == sample[i]
      white_hits += 1 if sample.include?(tipp[i])
    end

    return [black_hits, white_hits - black_hits]
  end

  # call-seq:
  #   hits_to_s(hits, [digits]) => str
  #
  # gibt eine Menschenlesbare Darstellung der Treffer zurueck
  def hits_to_s(hits, digits = @digits)

    string = ""

    string << "_" * (digits - hits[0] - hits[1])

    string << "X" * hits[0]

    string << "O" * hits[1]

  end

end
