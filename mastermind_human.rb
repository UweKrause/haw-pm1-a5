require_relative 'mastermind'

# Spielt Mastermind Mensch gegen Maschine<br>
# Die Klasse uebergibt die Eingaben des Nutzers an en Computer
# Author:: Lucas Anders
# Author:: Uwe Krause
class Mastermind_Human
  attr_reader :solved
  def initialize
    @mastermind = Mastermind.new()
    @solved = false
  end

  #liest den naechsten Tipp ein und uebergibt diesen an den Computer<br>
  #liefert dem Nutzer Feedback abhaengig von den Hits
  def next_try
    hits = @mastermind.try_attempt(get_input())
    if hits == [4,0]
      @solved = true
      return "Game Won!"
    end
    @mastermind.hits_to_s(hits)
  end

  #liest die Eingabe des Nutzers ein und konvertiert diese zu einem Array
  def get_input
    puts ">"
    input = gets.chomp
    ary = []
    input.each_char{|x| ary << x.to_i}
    return ary
  end
end