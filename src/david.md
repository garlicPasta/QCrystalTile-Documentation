#Ermittlung und Speicherung der Space Group Informationen

##Hilfsmittel


###JSON(JavaScript Object Notation ):

JSON ist ein Datenformat, in dem Informationen wie Arrays, Objekte etc.  in lesbarer Form gespeichert werden und bei bedarf wieder erzeugt werden können.
Die Daten werden dabei sprachunabhängig gespeichert und können somit auch sprachübergreifend genutzt werden.
Parser existieren in fast allen verfügbaren Programmiersprachen.



## Ermittlung & Speicherung:

Aus Effizienzgründen wurden die Informationen der einzelnen Raumgruppen in einem JSON-Array lokal gespeichert.
Die Informationen sowie die Transformationen der Raumgruppen haben wir von folgender Seite extrahiert:

[http://homepage.univie.ac.at/nikos.pinotsis/spacegroup.html](http://homepage.univie.ac.at/nikos.pinotsis/spacegroup.html)

Für eine übersichtlichere Nutzung wurde die html-Datei geparst und überflüssige Formatierungen entfernt.
Die Daten entsprachen nach dem Bearbeiten der einheitlichen Form:

	
* Space Group Name = P1
* Crystal System = TRICLINIC
* Laue Class = -1
* Point Group = 1
* Patterson Space Group # = 2
* Lattice Type = P
* symmetry= X,Y,Z 

wodurch die Daten leicht  getrennt und nach unseren Bedürfnissen als JSON-Array gespeichert werden konnten.

## SpaceGroupFactory

Die SpaceGroupFactory wird benutzt um die benötigte Raumgruppe aus der lokal gespeicherten JSON-Datei zu erzeugen.
Dazu wird die Raumgruppe über ihre ID identifiziert und anhand ihrer Daten wird ein SpaceGroup-Object erstellt.
Schwierigkeiten hierbei gab es bei den Transformationen, da diese als String in Koordinatentransformationen gespeichert sind:

Bsp: 	X, 1/2 +Y, Z

 wir aber mit 4x4 Matrizen arbeiten.

 	X	O 	0 	0 
 	0 	Y 	0 	1/2
 	0 	0 	Z 	0
 	0 	0 	0 	1

Um die Koordinatentransformationen in die 4*4 Matrizen umzuwandeln wurden die Transformationen jeweils geparst und dann in Zeilenvektoren umgewandelt.

Dabei war die einheitliche Form der Transformationen ein großer Vorteil, da Konstante, Operator und Variable immer in einer festen Reihenfolge angeordnet waren und somit leichter getrennt werden konnten.
Aus den Zeilenvektoren konnten nun die Transformationen in 4*4 Matrizen dargestellt werden.


##Gruppierung der Raumgruppen

Die SpaceGroupFactory bietet neben dem Erstellen der Raumgruppen noch die Möglichkeit die Raumgruppen nach bestimmten  Kriterien auszuwählen (Kristallsystem, Zentrierung).
Dabei wird wieder anhand der gesuchten Kriterien durch das JSON-Array iteriert und ein Set der angeforderten Transformationen zurückgegeben.
