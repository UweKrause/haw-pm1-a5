require_relative 'mastermind'

#
class Mastermind_Human
  attr_reader :solved
  def initialize
    @mastermind = Mastermind.new()
    @solved = false
  end
  def next_try
    hits = @mastermind.try_attempt(get_input())
    if hits == [4,0]
      @solved = true
      return "Game Won!"
  end 
    @mastermind.hits_to_s(hits)
  end
  def get_input
    puts ">"
    input = gets.chomp
      ary = []
      input.each_char{|x| ary << x.to_i}
        return ary
  end
end
#
#test = Mastermind_Human.new()
#while true
#  puts test.next_try()
#end
