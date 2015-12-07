# Mastermind Hauptklasse
# Author:: Lucas Anders

## Vorschauversion,
## noch lange nicht fertig!!

class Mastermind
  attr_reader :sample
  def initialize(seed = nil)
    # Spielregelvariablen hier:

    @felder = 4
    @versuche_max = 10
    @versuche = 0
    @range = (0..9)

    @sample = create_rand(seed)
  end
  
  def try_attempt(tipp)
    @versuche += 1
    if @versuche > 10
      return "Already lost"
    end
    if tipp == @sample
      return "Game won!"
    end
    
    return hits(tipp)
#    return hits_to_s(hits(tipp))
    
  end
    

  # Gibt string zurueck
  def create_rand(seed = nil)

    seeds = {
      1 => [1,2,3,4],
      2 => [3,4,5,6]}

    ary = []

    if (seed != nil) && seeds.has_key?(seed) && @felder == 4
      ary = seeds[seed]
    else
      while ary.length() < 4
        rand = rand(0..9)
        ary << rand unless ary.include?(rand)
      end
    end
    return ary

  end
def hits(tipp, sample = @sample)
    white_hits = 0
    black_hits = 0

    @felder.times do |i|
      black_hits += 1 if (tipp[i] == sample[i])
      white_hits += 1 if (sample.include?(tipp[i]))
    end
    return[black_hits,white_hits - black_hits]
  end

#  def hits(tipp, sample  = @sample)
#    black_hits = 0
#    white_hits = 0
#    @felder.times do |i|
#          black_hits += 1 if (tipp[i] == @sample[i])
#          white_hits += 1 if (@sample.include?(tipp[i]))
#        end
#        return[black_hits,white_hits - black_hits]
#  end

  def hits_to_s(hits, felder = @felder)

    string = ""
    string += "_" * (felder - hits[0] - hits[1])
    string += "X" * hits[0]
    string += "O" * hits[1]
  end
end
