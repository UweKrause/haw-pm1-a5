# Ein Mensch spielt Mastermind gegen den Computer
# Author:: Uwe Krause
require_relative 'mastermind_uwe'

mm = Mastermind.new(1)
# 1=> 1234

anzahl_versuche = 10

puts sample = mm.sample

(1..anzahl_versuche).each {

  versuch = gets.chomp
  v = mm.hits(versuch)
  
  puts versuch + " " + v[2]

  if v[2] == "XXXX"
    puts "Gewonnen!"
    break
  end

}

