require_relative 'game_over'
# Mastermind Hauptklasse
# Author:: Lucas Anders
# Author:: Uwe krause

# Die Mastermind-Klasse stellt das Spielfeld dar.<br>
# Attribute sind gleichzeitig die Regeln des Spiels:<br>
# Anzahl der Felder auf dem Spielfeld,<br>
# Anzahl der erlaubten Versuche,<br>
# Zahlraum der Moeglichkeiten ("Farben")
class Mastermind
  # Fuer Debugging / Testfaelle
  attr_reader :sample
  # Generiert das Spielfeld<br>
  # Wenn mit (gueltigem) Parameter aufgerufen, wird ein zu erratener Code festgelegt<br>
  # Ansonsten wird einer generiert
  def initialize(sample = nil)
    # Spielregelvariablen hier:
    @digits = 4
    @attempts_max = 10
    @attempts = 0
    @range = (0..9)
    @sample = create_rand(sample)

  end

  # Ein Spielzug des Spielers,<br>
  # Verbraucht einen Spielzug<br>
  # Liefert die Anzahl der Treffer zurueck
  def try_attempt(guess)
    raise ArgumentError unless check_attempt(guess)
    raise GameOver if @attempts >= @attempts_max

    @attempts += 1
    return hits(guess)
  end

  # Ueberprueft uebergebene Parameter auf Gueltigkeit
  def check_attempt(guess)
    return false unless (guess.is_a?(Array) && guess.length == 4)
    return false if guess.uniq != guess
    guess.each do |x|
      return false if !((0..9).include?(x))
    end
    return true
  end

  # erzeugt einen zufaelligen Tipp<br>
  # es kann eine Zahl uebergeben werden, um einen gewuenschten Tipp zu erzeugen<br>
  # Entweder Uebergabe eines gueltigen, 4-stelligen Wertes<br>
  # Oder Uebergabe eines der vorgegebenen Integer fuer Standard-Werte
  def create_rand(sample = nil)
    if sample == nil
      ary = []
      while ary.length() < 4
        rand = rand(0..9)
        ary << rand unless ary.include?(rand)
      end
      return ary
    end
    ary = []
    if check_attempt(sample)
      return sample
    else 
      raise ArgumentError
    end
    
  end

  # Ermittelt die korrekte Zahl von schwarzen und Weissen Treffern<br>
  # Gibt Array zurueck [int Schwarz, int Weiss, str String]
  def hits(tipp, sample = @sample)
    white_hits = 0
    black_hits = 0

    @digits.times do |i|
      black_hits += 1 if (tipp[i] == sample[i])
      white_hits += 1 if (sample.include?(tipp[i]))
    end
    return[black_hits,white_hits - black_hits]
  end

  # gibt eine Menschenlesbare Darstellung der Treffer zurueck
  def hits_to_s(hits, digits = @digits)
    string = ""
    string += "_" * (digits - hits[0] - hits[1])
    string += "X" * hits[0]
    string += "O" * hits[1]
  end
end