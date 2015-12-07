require_relative 'mastermind_lucas'

class Computer
  def initialize
    @mastermind = Mastermind.new(1)
    @left = possible_guesses()
    @last_guess
    @last_hits
  end

  def next_try
    if @last_guess == nil
      next_guess = [6,3,8,4]
    else
      next_guess = highest_score()
    end
    @last_hits = @mastermind.try_attempt(next_guess)
    @last_guess = next_guess
    update_possible
    return @left
  end

  def possible_guesses()
    ary = []
    10.times do |i|
      10.times do|j|
        10.times do |k|
          10.times do |l|
            ary << [i,j,k,l]
          end
        end
      end
    end
    return ary
  end

  def update_possible
    @left.delete_if do |x|
      !check(x,@last_hits)
    end
  end

  def score(last_guess = @last_guess)
    counter = 0
    hits = [[0,0],[0,1],[0,2],[0,3],[0,4],[1,0],[1,1],[1,2],[1,3],[2,0],[2,1],[2,2],[3,0],[4,0]]
    @left.each do |x|
      hits.each do |y|
        counter +=1 if !check(x,y,last_guess)
      end
    end
    return counter
  end

  def highest_score()
    return @left.max_by do |x|
      score(x)
    end

  end

  def check(guess, hits, last_guess = @last_guess)
    return true if hits[0] == identische_stellen(guess, last_guess) && hits[1] == gleiche_ziffern(guess, last_guess)
    return false
  end

  def identische_stellen(guess, other)
    counter = 0
    4.times do |i|
      counter += 1 if guess[i]==other[i]
    end
    return counter
  end

  def gleiche_ziffern(guess,other)
    counter = 0
    4.times do |i|
      4.times do |j|
        counter += 1 if guess[i] == other[j]
      end
    end
    return counter-identische_stellen(guess,other)
  end

  def aktualisiere_possible()
    @left.delete_if{|x| !(check(x,1,0))}
    return nil
  end

end

com = Computer.new()
10.times do
puts com.next_try().to_s + "\n"
end
 puts com.highest_score()
