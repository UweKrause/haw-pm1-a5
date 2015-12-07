# Diese Klasse loest die Mastermind-challenge
# Author:: Uwe Krause

require 'mastermind_uwe'

class MastermindSolver
  # fuer debugausgabe
  attr_reader :s
  attr_reader :mm
  def initialize(vorgegebener_code = nil)

    # die zu knackende Nuss

    @mm = Mastermind.new(vorgegebener_code)

    # moegliche "Farben"
    @range = @mm.range

    # Anzahl der Felder
    @felder = @mm.felder

    # Anzahl der erlaubten versuche
    @versuche = 10

    # alle bisher nicht ausgeschlossenen Moeglichkeiten
    @alle_moeglichen_codes = generiere_alle_moeglichkeiten(@range)
  end

  def generiere_alle_moeglichkeiten(range = @range, felder = @felder)
    # erstellt die Menge aller moeglichen Rateversuche,
    # doppelte nicht erlaubt
    moeglichkeiten_verbleibend = (0..9).to_a.permutation(@felder).to_a

    # Ein durchmischen der Werte sort dafuer, dass im pop nicht immer der gleiche Wert genommen wird.
    # Dies verringert die durchschnittliche Anzahl der Versuche
    moeglichkeiten_verbleibend.shuffle!
  end

  def waehle_einen_code!
    # destruktive Methode, entfernt den gewahlten Code aus den Moeglichkeiten
    #p @alle_moeglichen_codes
    @alle_moeglichen_codes.pop
  end

  def frage_treffer_ab(code)
    @mm.hits(code.join)
  end

  def gewonnen?(treffer, felder = @felder)
    treffer[0] == felder ? true : false

  end

  def entferne_codes!(moeglichkeit_aktuelle, schwarze, weisse, moeglichkeiten_verbleibend = @alle_moeglichen_codes)
    # destruktiv, entfernt alle nicht passenden Code aus der Liste der verbleibenden Codes

    # select! geht ueber das array und liefert ein array mit allen Werten, fuer die der Block zu true auswertet
    moeglichkeiten_verbleibend.select! { |moeglichkeit|

      # berechnet Anzahl der Direkten treffer
      black_hits_berechnet = 0

      # geht durch jeden Index
      # erlaubt so den direkten Vergleich zweier Arrays mit gleicher Kardinalitaet
      moeglichkeit.each_index { |i|
        black_hits_berechnet += 1 if moeglichkeit[i] == moeglichkeit_aktuelle[i]
      }

      # Die Anzahl der unterschiedlichen Elemente
      differenz = (moeglichkeit - moeglichkeit_aktuelle).size

      # white-hits = Felder - Differenz - black_hits
      white_hits_berechnet = @felder - differenz - black_hits_berechnet

      # Bedingung fuer select!
      # Wenn diese Moeglichkeit den gleichen Rueckgabewert,
      # wie der tatsaechliche Versuch hat,
      # behalte ihn als gueltigen Versuch fuer die Zukunft
      [black_hits_berechnet, white_hits_berechnet] == [schwarze, weisse]
    }

    # rueckgabewert ist hier das von select! bereinigte Array
  end

  def automatisiere()
    # 1 initialize
    # 2 waehle code
    # 3 frage Treffer ab
    # 4 Gewonnen?
    # 5 Entferne ungueltige Codes
    # 6 Goto 2

    anzahl_versuche = 0

    @versuche.times {

      anzahl_versuche += 1

      pruefcode = waehle_einen_code!()
      treffer = frage_treffer_ab(pruefcode)

      if gewonnen?(treffer, @felder)

        # bricht aus der Schleife aus
        return anzahl_versuche

      end

      entferne_codes!(pruefcode, treffer[0], treffer[1], @alle_moeglichen_codes)

      # und wieder von vorn, huuuui
    }

    # wenn nicht innerhalb der vorgegebene Versuche geschafft
    return false if anzahl_versuche >= @versuche

  end

end

## Soll durchschnitt berechnet werden?
durchschnitt_berechnen = false
# macht nur sinn, wenn ein fester Wert vorgegebe wird
durchschnitt_berechnen ? durchschnitt_vorgabe = "1234" : nil

versuche_gesamt = []
versuche_gesamt_anzahl = 10

versuche_gesamt_anzahl.times do
  mms = MastermindSolver.new(durchschnitt_vorgabe)

  versuche = mms.automatisiere
  versuche_gesamt << versuche
  puts "(#{mms.mm}) Gewonnen in #{versuche} Versuchen"
end

if durchschnitt_berechnen
  durchschnitt =  versuche_gesamt.inject(0.0) { |sum, el| sum + el } / versuche_gesamt.size
  puts "Durchschnittliche Versuche bei #{versuche_gesamt_anzahl} Durchlaeufen: #{durchschnitt}"
end

