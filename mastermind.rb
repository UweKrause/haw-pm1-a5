# Mastermind Hauptklasse
# Author:: Lucas Anders
class Mastermind
  attr_reader :sample
  def initialize(sample = nil)
    # Spielregelvariablen hier:
    @digits = 4
    @attempts_max = 10
    @attempts = 0
    @range = (0..9)
    if check_attempt(sample)
      @sample = sample
    else
      @sample = create_rand(sample)
    end
    check_attempt(sample) ? @sample = sample : @sample = create_rand(sample)
  end

  #prueft den Tipp
  def try_attempt(guess)
    raise ArgumentError unless check_attempt(guess)
    raise ArgumentError if @attempts >= @attempts_max

    @attempts += 1
    puts @attempts
    return hits(guess)
  end

  def check_attempt(guess)
    return false unless (guess.is_a?(Array) && guess.length == 4)
    return false if guess.uniq != guess
    guess.each do |x|
      return false if !((0..9).include?(x))
    end
    return true
  end

  # erzeugt einen zufaelligen Tipp
  # es kann eine Zahl uebergeben werden, um einen gewuenschten Tipp zu erzeugen
  def create_rand(seed = nil)
    seeds = {
      1 => [1,2,3,4],
      2 => [3,4,5,6]}
    ary = []

    if (seed != nil) && seeds.has_key?(seed) && @digits == 4
      ary = seeds[seed]
    else
      while ary.length() < 4
        rand = rand(0..9)
        ary << rand unless ary.include?(rand)
      end
    end
    return ary
  end

  # ermittelt die Black Hits und White Hits zu einem Tipp
  def hits(tipp, sample = @sample)
    white_hits = 0
    black_hits = 0

    @digits.times do |i|
      black_hits += 1 if (tipp[i] == sample[i])
      white_hits += 1 if (sample.include?(tipp[i]))
    end
    return[black_hits,white_hits - black_hits]
  end

  # gibt die Hits in einer lesbaren Darstellung zurück
  def hits_to_s(hits, digits = @digits)
    string = ""
    string += "_" * (digits - hits[0] - hits[1])
    string += "X" * hits[0]
    string += "O" * hits[1]
  end
end