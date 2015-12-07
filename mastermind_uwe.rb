# Mastermind Hauptklasse
# Author:: Uwe Krause

class Mastermind
  # debug-option
  attr_reader :sample

  # Stelt die Einstellungen der Solver-Klasse zur Verfuegung
  attr_reader :felder, :range
  def initialize(vorgabe = nil)
    # Vorgabe als vierstelliger String erwartet!

    ##
    # Spielregelvariablen hier:
    ##

    @felder = 4
    @versuche = 10
    @range = (0..9)

    ##
    # Instanzvariablen
    ##
    @sample = create_rand(@felder, vorgabe)

  end

  # Gibt zufaelligen String zurueck
  def create_rand(felder = @felder, vorgabe = nil)

    if ((vorgabe != nil) && vorgabe.size == felder)
      s = vorgabe
    else
      a = @range.to_a.sample(felder)
      s = a[0].to_s + a[1].to_s + a[2].to_s + a[3].to_s
    end

    s

  end

  def hits(tipp, sample  = @sample)
    raise RangeError unless tipp.is_a?(String)
    raise RangeError unless tipp.length == sample.length

    schwarz = []
    weiss = []
    i = 0

    tipp.length.times do

      # Das funktioniert auf diese Weise nur, wenn im Zufallswert keine Farben mehrfach vergeben sein duerfen!

      unless (schwarz.include?(tipp[i]))
        #  wenn dieser Tipp bereits schwarz war, darf er auch nicht mehr als weiss gewertet werden

        if tipp[i] == sample[i]
          # black hit
          schwarz << tipp[i]

          # wurde bereits vorher nach diesem Tipp gefragt, waere er in weiss, er kann aber nicht gleichzeitig schwarz und weiss sein
          # Solange im Zufallswert keine doppelten Werte erlaubt sind!!!
          weiss.delete(tipp[i])

        elsif sample.include?(tipp[i])
          # white hit
          weiss << tipp[i] unless weiss.include?(tipp[i])
        end
      end

      i += 1
    end
    # [Anzahl schwarze Treffer, Anzahl weisse Treffer, Als String formartiert]
    [schwarz.size, weiss.size, hits_to_s(schwarz.size, weiss.size)]

  end

  def hits_to_s(black, white, felder = @felder)

    string = ""
    string += "X" * black
    string += "O" * white
    string += "_" * (felder - black - white)
  end

  def to_s
    @sample
  end
end

#p Mastermind.new.hits("3523", "2532")
#mm = Mastermind.new()
#p mm.sample