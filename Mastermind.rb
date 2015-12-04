# Mastermind Hauptklasse
# Author:: Uwe Krause

## Vorschauversion,
## noch lange nicht fertig!!

class Mastermind
  attr_reader :sample
  def initialize()
    # Spielregelvariablen hier:

    @felder = 4
    @versuche = 10
    @range = (0..9)

    @sample = create_rand
  end

  def create_rand
    @range.to_a.sample(@felder)
  end

  def try(tipp)
    raise RangeError unless tipp.is_a?(String)
    raise RangeError unless tipp.length == @felder

    # TODO: funktionierende Abfrage, ob nur Ziffern eingegeben wurden
    #raise RangeError unless tipp =~ /[0-9]/ # ... filtert nicht korrekt!

    # TODO: entweder keine Exceptions schmeissen, oder sie wenigstens anstaendig abfangen
    # rescue ???

    black = black_hits(tipp)
    white = white_hits(tipp)

    hits_to_s(black, white)

  end

  def hits_to_s(black, white, felder = @felder)

    string = ""
    string += "X" * black
    string += "O" * white
    string += "_" * (felder - black - white)
  end

  def black_hits(string, sample = @sample)

    black_hits = 0

    i = 0
    @felder.times do

      black_hits += 1 if string[i].to_i == sample[i]
      i += 1
    end

    black_hits
  end

  def white_hits(string, sample = @sample)

    white_hits = 0
    i = 0
    @felder.times  do

      white_hits += 1 if sample.include?(string[i].to_i)
      i += 1
    end

    white_hits - self.black_hits(string, sample)

  end
end

mm = Mastermind.new()

winner = ""

# nur ein Beispiel, wie ein Script aussehen koennte
(1..10).each {

  p mm.sample
  tipp = gets.chomp

  if mm.try(tipp) == "XXXX"

    puts "Gewonnen!!"
    break
  end

}

