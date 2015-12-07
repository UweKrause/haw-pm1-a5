# Eine Curses-Kommandozeilenoberflaeche fuer den Mensch gegen Maschine Modus
# MUSS IN KOMMANDOZEILE GESTARTET WERDEN!
# Author:: Uwe Krause

require_relative 'mastermind_uwe'

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
    oz = 3
    os = 4
  else
    oz = 0
    os = 0
  end

  ##

  win.setpos(oz -1 , os)
  win << "Willkommen bei Mastermind, der Computer hat sich einen Code ausgedacht, kannst Du ihn loesen?"

  win.setpos(oz, os)
  win << "Tipp?"

  mm = Mastermind.new("1234")

  (1..10).each { |i|

    win.setpos(oz + i, os)

    # liest Benutzereingabe ein
    benutzereingabe = win.getstr
    
    # TODO: Fehlerhafte Eingaben abfangen!

    # setzt den cursor wieder zurueck, vor die Eingabe
    win.setpos(oz + i, os)

    # gibt die Eingabe und zusaetzlich die Auswertung aus

    auswertung = mm.hits(benutzereingabe)[2]
    win << "#{benutzereingabe} #{auswertung}"

    if auswertung == "XXXX"
      win.setpos(oz + i + 1, os)
      win.beep
      win << "Gewonnen in #{i} Versuchen!"

      # TODO: Fenster nicht schliessen!
      sleep(5.minutes)
    end

  }

  # TODO: FENSTER NICHT SCHLIESSEN,
  # man sieht ja nicht mal, dass man gewonnen hat...
  # Eine Frage nach einer neuen Runde waere nett!
  # Dann Fenster komplett leeren!

rescue
  puts "This program must be run in Konsole Window!"
end
