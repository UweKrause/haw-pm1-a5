# Mastermind Hauptklasse
# Author:: Uwe Krause

## Vorschauversion,
## noch lange nicht fertig!!

class Mastermind
  attr_reader :sample
  def initialize(seed = nil)
    # Spielregelvariablen hier:

    @felder = 4
    @versuche = 10
    @range = (0..9)

    @sample = create_rand(seed)
  end

  # Gibt string zurueck
  def create_rand(seed = nil)

    seeds = {
      1 => "1234",
      2 => "3456"}

    if (seed != nil) && seeds.has_key?(seed) && @felder == 4
      seeds[seed]
    else
      a = @range.to_a.sample(@felder)
      s = a[0].to_s + a[1].to_s + a[2].to_s + a[3].to_s
    end

  end

  def hits(tipp, sample  = @sample)
    raise RangeError unless tipp.is_a?(String)
    raise RangeError unless tipp.length == sample.length

    # TODO: funktionierende Abfrage, ob nur Ziffern eingegeben wurden
    #raise RangeError unless tipp =~ /[0-9]/ # ... filtert nicht korrekt!

    # TODO: entweder keine Exceptions schmeissen, oder sie wenigstens anstaendig abfangen
    # rescue ???

    schwarz = []
    weiss = []
    i = 0

    tipp.length.times do

      unless (schwarz.include?(tipp[i]))

        if tipp[i] == sample[i]
          schwarz << tipp[i]
          weiss.delete(tipp[i])
        elsif sample.include?(tipp[i])

          weiss << tipp[i] unless weiss.include?(tipp[i])
        end
      end

      i += 1
    end

    ret = [schwarz.size, weiss.size, hits_to_s(schwarz.size, weiss.size)]

  end

  def hits_to_s(black, white, felder = @felder)

    string = ""
    string += "X" * black
    string += "O" * white
    string += "_" * (felder - black - white)
  end
end
