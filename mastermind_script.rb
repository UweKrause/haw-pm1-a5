require_relative 'mastermind_human'
require_relative 'mastermind_solver'

# Dies ist das Script fuer das Spiel.
# Auswahlmoeglichkeiten:
# Mensch gegen Computer,
# Computer gegen Computer
# Author:: Lucas Anders

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
    puts "Playing Mastermind against the computer. Whats your try?"
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
    puts "Game Over"
    break
  rescue ArgumentError
    puts "invalid Number, please enter a Number with 4 digits, without duplicates"
  rescue
  end
end

