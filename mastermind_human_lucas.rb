require_relative 'mastermind_lucas'

mm = Mastermind.new(1)

while true
  input = gets.chomp
  ary = []
  input.each_char{|x| ary << x.to_i}
    puts mm.hits_to_s(mm.try_attempt(ary))
end
