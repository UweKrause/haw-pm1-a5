require_relative 'mastermind_human_lucas'
require_relative 'mastermind_solver_third_try'

#konvertiert die benutzereingabe zu einem Array, fuer den Computer-Solver
def get_input
    puts ">"
    input = gets.chomp
      ary = []
      input.each_char{|x| ary << x.to_i}
        return ary
  end



puts "Welcome, Mastermind! \n Please enter Computer or Human"
input = gets.chomp
if input.eql?("computer")
  puts "Please enter your Number, the Computer will solve it"
  
  mastermind = Mastermind_Solver.new(get_input)
elsif input.eql?("human")
  mastermind = Mastermind_Human.new()
end

while mastermind.solved == false
  puts mastermind.next_try()
end



