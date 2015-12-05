# Eine Curses-Kommandozeilenoberflaeche fuer den Mensch gegen Maschine Modus
# MUSS IN KOMMANDOZEILE GESTARTET WERDEN!
# Author:: Uwe Krause

# faengt Fehler ab, wenn nicht in Komandozeile gestartet,
# keine curses Oberflaeche in Eclipse verfuegbar
begin
  require 'curses'

  Curses.init_screen()

  win = Curses::Window.new(0,0,0,0)

  box = true
  if box
    win.box("|", "-")
    win.setpos(0, 2)
    win << "Mastermind: Mensch gegen Maschine"
    #offset
    oz = 2
    os = 2
  else
    oz = 0
    os = 0
  end

  ##

  win.setpos(oz, os)
  win << "Tipp?"

  (1..10).each { |i|

    win.setpos(oz + i, os)

    # liest Benutzereingabe ein
    a = win.getstr

    # setzt den cursor wieder zurueck, vor die Eingabe
    win.setpos(oz + i, os)

    # gibt die Eingabe und zusaetzlich die Auswertung aus
    # TODO: Auswertung nicht nur simulieren
    win << a + " [XXOO]"

  }

  win.close
rescue
  puts "This program must be run in Konsole Window!"
end
