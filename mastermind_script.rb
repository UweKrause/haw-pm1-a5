require_relative 'mastermind_human'
require_relative 'mastermind_solver'

#konvertiert die benutzereingabe zu einem Array, fuer den Computer-Solver
def get_input
  puts ">"
  input = gets.chomp
  ary = []
  input.each_char{|x| ary << x.to_i}
  return ary
end

puts "Welcome, Mastermind! \n Please enter Computer or Human"
while true
  input = gets.chomp
  if input.eql?("computer")
    puts "Please enter your Number, the Computer will solve it"

    while true
      begin
        mastermind = Mastermind_Solver.new(get_input)
        break
      rescue ArgumentError
        puts "invalid Number, please enter a Number with 4 digits, without duplicates"
      end
    end
    break
  elsif input.eql?("human")
    mastermind = Mastermind_Human.new()
    break
  else
    puts "invalid input \n Please enter Computer or Human"
  end
end

while mastermind.solved == false
  begin
    puts mastermind.next_try()
  rescue GameOver
    puts "No more guesses left"
    break
  rescue ArgumentError
    puts "invalid Number, please enter a Number with 4 digits, without duplicates"
  end
end

