# Visualisierung

Für das Rendering der 3-dimensionalen Voronoi-Zellen wird die OpenGL Bibliothek Jzy3d [@jzy3d] verwendet. Jzy3d ist eine quelloffene Java Bibliothek, die speziell auf die Visualisierung wissenschaftlicher Daten ausgerichtet ist.
Die Architektur der Benutzerschnittstelle wurde nach dem Model-View-Controller (kurz MVC) Muster entworfen. Im Model sind alle Aktivitäten gekapselt, die zur Berechnung der Punktmenge der ausgewählten Raumgruppe notwendig sind. Auf Grundlage dieser Punktmenge wird im Controller die Voronoi-Tesselierung durchgeführt. Darüber hinaus sind im Controller Statusinformationen enthalten, die einzelne Aspekte der Visualisierung beeinflussen. Sobald sich diese Statusinformationen ändern, benachrichtigt der Controller den View darüber, dass die Ansicht und die darin enthaltenen geometrischen Objekte erneuert werden müssen.
Nachfolgend wird eine Übersicht über die Klassen der Visualisierung gegeben.
Um eine Ausgabe zu erzeugen, muss der Nutzer eine Raumgruppe auswählen und einen Ausgangspunkt sowie die Gittergröße festlegen. Die Gittergröße legt in diesem Zusammenahng den Begrenzungsrahmen fest, in dem die Punkte liegen müssen, die durch die Tranformationen der Raumgruppe entstehen.

![mvc](img/mvc.png)

## Bedienkonzept

Die Benutzeroberfläche ist so gestaltet, dass alle relevanten Informationen durch den Nutzer sofort erfasst werden können. Hierbei wurde versucht, die sichtbaren Elemente hinsichtlich des logischen Zusammenhangs zu unterteilen. Um die Nutzerinterkation während der Berechnung einer Raumgruppe nicht zu beeinträchtigen, erfolgt die Berechnung asynchron. Das hat den Vorteil, dass die Oberfläche weiterhin bedienbar bleibt. Der grundlegende Aufbau der Benutzeroberfläche wird in der nachfolgenden Abbildung dargestellt.

![GUI](img/gui.pdf)

Die Bedeutung der einzelnen Punkte lautet wie folgt:

A. Gittermodell
B. Art der Darstellung
C. Auswahl der Raumgruppe
D. Festlegung des Ausgangspunktes und der Gittergröße
E. Diverse Ansichtsoptionen
F. Statistik
G. Aktivitätsanzeige für die Berechnung

Zusätzlich zu den sichtbaren Elementen auf der Oberfläche stehen weitere Einstellungsmöglichkeiten über ein Kontextmenü auf dem Gittermodell zur Verfügung. Alle Einstellungen, die durch den Nutzer vorgenommen wurden, werden in einem Nutzerprofil gespeichert und beim Neustart der Applikation wieder hergestellt.
Die Interaktion mit dem Gittermodell erfolgt über die Maus. So kann der gesamte Inhalt gedreht werden oder durch einen Doppelklick im Ansichtsfenster automatisch rotiert werden. Um den dargestellten Ausschnitt zu vergrößern bzw. zu verkleinern, kann über das Mausrad der Zoom verändert werden. Ein Klick auf eine Voronoi-Zelle bewirkt, dass diese Zelle ausgeblendet wird, um das Innere eines Kristalls bzw. Bereiche sichtbar zu machen, die vorher verdeckt wurden.

## Ansichtsoptionen

Um die Auswertung der Visualisierung zu unterstützen, stehen verschiedene Optionen zur Verfügung, um einzelne Aspekte andersartig darzustellen. Eine erste Option besteht darin, die Darstellung zwischen Raumgruppe und Kachelung zu wechseln. In der Darstellungsart Raumgruppe wird die berechnete Punktmenge der ausgewählten Raumgruppe als Punktwolke ausgegeben. Der blaue Punkt im Gittermodell repräsentiert den Ausgangspunkt, der für die Transformationen herangezogen wird. In dieser Visualisierung wird noch keine Voronoi-Tesselierung vorgenommen. Die Voronoi-Zellen werden erst in der Darstellung Kachelung berechnet.
Die beiden Darstellungsarten sind in der folgenden Abbildung gegenübergestellt.

![View](img/view.pdf)

Wie bereits erwähnt, hat der Nutzer die Möglichkeit, einzelne Zellen auszublenden, um verdeckte Bereiche sichtbar zu machen. Eine weitere Möglichkeit, die inneren Zellen zu enthüllen, besteht darin, einen Abstand zwischen die Zellen einzufügen. Um das zu erreichen wird von jeder Zelle der Abstand zum Mittelpunkt des Gittermodells erhöht, somit entsteht der Eindruck, dass der Kristall explodiert.
Nachfolgende Abbildung zeigt einen Kristall mit zwei unterschiedlichen Abstandsfaktoren.

![Explode](img/explode.pdf)

Die Zellen werden standardmäßig in einer einheitlichen Farbe dargestellt. Um die visuelle Abgrenzung der Zellen voneinander zu erhöhen, stehen weitere Farbschemata zur Verfügung. Das erste Farbschema Nach Zelle weist jeder Zelle eine eigene Farbe zu. Auf diese Weise kann die Form der Zellen besser erfasst werden. Allerdings wird nicht deutlich, wo sich die Zellen berühren bzw. welche Kontaktflächen es gibt. Aus diesem Grund gibt es das Farbschema Nach Facette. Hierbei werden den Facetten, die hinsichtlich Form und Fläche gleich sind, dieselbe Farbe zugewiesen (siehe dazu Kapitel “Färbungsalgorithmus für äquivalent Zellwände”). Diese Darstellungsweise trägt ebenfalls dazu bei, zu erkennen aus wie vielen verschiedenen Facetten eine Zelle besteht.
In der nachfolgenden Abbildung sind die verfügbaren Farbschemata gegenüber gestellt.
![Colors](img/colors.pdf)

## Zusammenfassung

Die Entscheidung, Jzy3d zum Rendering der 3D Objekte zu verwenden, war im Nachhinein die richtige Wahl, da die Lernkurve im Umgang mit der Bibliothek relativ flach verlief und das Abstraktionsniveau so angemessen ist, das keine tiefgreifenden OpenGL Kenntnisse notwendig waren. Der einzige Nachteil bestand darin, dass die Dokumentation weitesgehend unvollständig ist. Aus diesem Grund waren die aufkommenden Probleme nicht immer einfach zu lösen. Ein solches Problem trat beispielsweise beim Entfernen von geometrischen Objekten aus der 3D Szene auf. Das passiert in dem Moment, wenn durch eine erneute Voronoi-Tesselierung massenweise Polygone entfernt werden müssen, die ungültig geworden sind. Der vorgeschriebene Weg zum Entfernen von Objekten führte zu einer starken Beeinträchtigung der Performance, was zur Folge hatte, dass die Benutzeroberfläche zeitweise nicht reagiert hat. Insofern war es notwendig, sich mit dem Quelltext von Jzy3d näher auseinander zu setzen, um eine entsprechende Lösung zu entwickeln. Ein weiteres besteht darin, dass Jzy3d bzw. die zugrundeliegende Bibliothek JOGL [@jogl] nicht mit allen Linux Distributionen kompatibel ist.
