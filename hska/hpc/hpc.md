---
title: Zusammenfassung _I W909 High Performance Computing_ Wintersemester 2014/2015
author: Florian Wilhelm
---

* [Markdown Quelle dieses Dokuments](https://github.com/sputnik27/documents/tree/master/hska/hpc)
* [Ilias Link zur Vorlesung](https://ilias.hs-karlsruhe.de/goto.php?target=crs_29413&client_id=HSKA)
* [Fachschaftswiki zur Vorlesung](https://www.hska.info/vorlesungen/unterlagen/highperformancecomputing)

# 1 Introduction

## Literatur

* [Parallele Programmierung](http://link.springer.com/book/10.1007%2F978-3-642-13604-7)
* [The OpenCL Programming Book](http://www.fixstars.com/en/opencl/book/)

## Wichtige Kennzahlen

### Speedup

* Maß für relativen Geschwindigkeitsgewinn
* Verhältnis zwischen sequentieller und paralleler Ausführungszeit

| Variable | Bedeutung |
| ----- | ----- |
| $t_{S}$ | Sequentielle Laufzeit |
| $t_{P}$ | Parallele Laufzeit |
| $S$  | Speedup |

$S = \frac{t_{S}}{t_{P}}$

Beispiel für Speedup

$t_{S} = 60$ Sekunden

$t_{P} = 30$ Sekunden

$S = \frac{60}{30} = 2$

* Idealer Speedup ist gleich Anzahl der Prozessoren
* Programme sind in der Regel nicht voll parallelisierbar (aufgrund von Datenabhängigkeiten)
* Möglich: Superlinearer Speedup (mehr als Anzahl Prozessoren) durch Cache-Effekte


### Effizienz

| Variable | Bedeutung |
| ----- | ----- |
|$E$ | Effizienz |
|$P$ | Anzahl Prozessoren (optimaler Speedup) |

$E = \frac{S}{P}$

Beispiel für Effizienz

$S = 10$

$P = 16$

$E = \frac{10}{16} = 0.625$

* Ideale Effizienz: 1
* Wertebereich $E \in {[0,1]}$

### Amdahl

[Wikipedia - Amdahl's law](http://en.wikipedia.org/wiki/Amdahl%27s_law)

| Variable | Bedeutung |
| ----- | ----- |
|$t_{S}$ | Anteil der sequentiell ausgeführt wird |
|$t_{P}$ | Anteil der parallel ausgeführt wird |
|$P$ | Anzahl Prozessoren (optimaler Speedup) |

$S = \frac{1}{t_{S} + \frac{t_{P}}{P}} = \frac{1}{(1 - t_{P}) + \frac{t_{P}}{P}}$

* Pessimistische Abschätzung. Aussage: Parallelisierung bringt keinen wesentlichen Speedup und ist nicht effizient.
* Größtmögliche Beschleunigung ist linear
* Problemgröße spielt keine Rolle

![Illustration von Amdahl's Abschätzung (Lizenz: CC BY-SA Daniels220 at English Wikipedia http://commons.wikimedia.org/wiki/File:AmdahlsLaw.svg)](picture/AmdahlsLaw_german.png)

Beispiel für Amdahl mit 5% parallelem Anteil und steigener Anzahl an CPUs.

$S$      | $t_{S}$| $t_{P}$| $P$
---------|--------|--------|------
1,0000   |  0,05  |  0,95  |  1
1,9048   |        |        |  2
3,4783   |        |        |  4
5,9259   |        |        |  8
9,1429   |        |        |  16
12,5490  |        |        |  32
15,4217  |        |        |  64
17,4150  |        |        |  128
18,6620  |        |        |  265
19,2844  |        |        |  512
19,6357  |        |        |  1.024  
19,8162  |        |        |  2.048  
19,9077  |        |        |  4.096  
19,9537  |        |        |  8.192  
19,9768  |        |        |  16.384
19,9884  |        |        |  32.768
19,9942  |        |        |  65.536
19,9971  |        |        |  131.072
19,9986  |        |        |  262.144
19,9993  |        |        |  524.288


### Gustafson

[Wikipedia - Gustafson's law](http://en.wikipedia.org/wiki/Gustafson%27s_law)

$S = t_{S} + P * t_{P}$

* [Paper von Gustafson](http://www.johngustafson.net/pubs/pub13/amdahl.htm)
* Bezieht Problemgröße mit ein
* Aussage: Parallelisierung kann jeden Speedup und einen hohen Grad an Effizienz erreichen wenn das Problem groß genug ist und genug CPU genutzt wird.

Gleiches Beispiel wie bei Amdahl

$S$         | $t_{S}$| $t_{P}$| $P$
------------|--------|--------|------
1,00        |  0,05  |  0,95  |  1
1,95        |        |        |  2
3,85        |        |        |  4
7,65        |        |        |  8
15,25       |        |        |  16
30,45       |        |        |  32
60,85       |        |        |  64
121,65      |        |        |  128
251,80      |        |        |  265
486,45      |        |        |  512
972,85      |        |        |  1.024  
1.945,65    |        |        |  2.048  
3.891,25    |        |        |  4.096  
7.782,45    |        |        |  8.192  
15.564,85   |        |        |  16.384
31.129,65   |        |        |  32.768
62.259,25   |        |        |  65.536
124.518,45  |        |        |  131.072
249.036,85  |        |        |  262.144
498.073,65  |        |        |  524.288


### FLOPS

* Floating Point Operations Per Second
* Anzahl der Gleitkommaoperationen (Addition, Subtraktion und/oder Multiplikation, Division) pro Sekunde


### FLOPS pro Watt

* Maß für Energieeffizienz
* Proportional zu Kosten (Strom)

## Speichermodelle

### Shared Memory

* Ein globaler Adressraum auf den alle Prozessoren zugreifen
* Änderungen im Speicher sind für alle Prozessoren sichtbar (uu. nicht sofort)


### Distributed Memory

* Zugriff auf Speicher von anderem Prozessor erfolgt über Netzwerk
* Jeder Prozessor hat eigenen Speicher
* Änderungen eines Prozessors sind nicht für andere sichtbar


### Vor- und Nachteile

| Shared Memory | Distributed Memory |
| ------------- | ------------------ |
| + Einfacher Datenaustausch | - Schwerer Datenaustausch (manueller Aufwand) |
| - Schwerer Datenzugriff (manueller Aufwand) | + Einfacher Datenzugriff |
| + Schnelle und einfache parallelisierung | - Kommunikation muss entworfen werden |
| - Beschränkte Skalierbarkeit | + (uU.) gute Skalierbarkeit |

### Hybride Programmierung

* Mischung aus Shared und Distributed
* Manueller Aufwand für Datenaustauch und Datenzugriff
* Kommunikation notwendig
* Dafür: Gute Skalierbarkeit


# 2 openMP

[openmp.org](http://www.openmp.org)

* Code läuft per Default sequentiell, wird nur bei Bedarf parallelisiert
* Steuerung über Compilerdirektiven (#pragma)
* Variablen können shared und private sein

```{breaklines=true .c}
int s = 0;
int p;
#pragma omp parallel shared(s) private(p)
{
  p = 0;
  s++;
  p++;
  printf("s = %d\n", s);
  printf("p = %d\n", p);
}
```
> s ist am Ende 4, p ist 1

```{breaklines=true .c}
int num_threads;
int id;

#pragma omp parallel private(id, num_threads)
{
  num_threads = omp_get_num_threads();
  id = omp_get_thread_num();
  printf("Hello, my Id is: %d %d \n", id, num_threads);
}
```

## barrier

Erst wenn alle Threads diese Stelle erreicht haben dürfen sie weiter machen.

## critical

Nur ein Thread darf diesen Code ausführen.

## atomic

Der Code wird atomar (ohne Unterbrechung) ausgeführt.

# 3 MPI

[MPI Funktionen](http://mpi.deino.net/mpi_functions/)

## MPI API Summary

### MPI_Init

```{breaklines=true .c}
int MPI_Init(int *argc, char ***argv);
```

### MPI_Send

```{breaklines=true .c}
int MPI_Send(void *buffer, int count, MPI_Datatype datatype, int destination, int tag, MPI_Comm communicator);
```
#### Out Parameters
* none

### MPI_Recv

```{breaklines=true .c}
int MPI_Recv(void *buffer, int count, MPI_Datatype datatype, int source, int tag, MPI_Comm communicator, MPI_Status status);
```
#### Out Parameters
* `buffer`
* `status`

### MPI_Reduce

```{breaklines=true .c}
int MPI_Reduce(void *sendbuffer, void *recievebuffer, int count, MPI_Datatype datatype, MPI_Op operation, int rootprocess, MPI_Comm communicator);
```
#### Out Parameters
* `recievebuffer`


```{breaklines=true .c}

```

```{breaklines=true .c}

```


# 4 CPU

## CPU und Caches

### Speicherhierarchie

Es gibt kleinen und schnellen Speicher, und langsamen und billigen.

Es gilt folgende Hirachie (von schnell nach langsam)

* Register
* L1 Cache
* L2 und L3 Cache
* Hauptspeicher
* Solid State Disk
* Festplatte
* Optische Datenträger
* Magnetische Datenträger



## Von-Neumann-Zyklus

fetch -> decode -> fetch operands -> execute -> write back --> fetch ..

Optimierungen für diesen Zyklus

* Höhere Bitparallelität (64 statt 32 Bit)
* Komplexes Rechenwerk (weniger Zyklen)
* Prefetching
* Mehrere Recheneinheiten (superskalare CPUs)
	* Beschleunigt die Befehlsausführung
	* Wird in allen heute gängigen CPUs gemacht
	* Es gibt drei Arten von Superskalarität
		* Statisches Scheduling

TODO
		
		* Dynamisches Scheduling

CPU bestimmt welche Befehle parallel ausgeführt werden und in welcher Reihenfolge (Out of Order Execution)

		* VLIW-Prozessoren

(Siehe nächsten Punkt)

* Very long instruction words (VLIW)
	* Compiler sucht parallel ausführbare Bereiche
	* Benutzung längerer Befehle, in denen parallel auszuführende Befehle vorgegeben sind



## Cache

* Kleiner, schneller Zwischenspeicher
* Reduziert von-Neumann-Flaschenhals (Daten- und Befehlsbus sind Engpass zwischen Prozessor und Speicher)
* Cache-Controller (CC) ist für Steuerung zuständig -> Prozessor kann während Warten auf Cache andere Operationen ausführen
* Cache enthält Kopie von Teilen vom Hauptspeicher
* Wenn der Prozessor Daten anfordert prüft CC ob Daten im Cache sind
	* Wenn ja (Cache Hit) werden Daten vom CC geladen und dem Prozessor zur Verfügung gestellt
	* Wenn nein (Cache Miss) lädt CC Daten aus RAM
		* Es wird nicht nur ein Wert sondern ein ganzer Block geladen

### Cache Effizienz

* Hängt maßgeblich von Cache-Miss-Rate ab
* Misses sind viel langsamer als Hits
* "Lokalität"
	* räumlich -> Benötigte Daten liegen im Speicher nah beieinander
	* zeitlich -> Es wird mehrfach auf die selbe Speicherstelle zugegriffen

Wenn Misses teuer sind, warum wird dann nicht einfach der Cache größer gemacht?
	* Zugriffszeit steigt, da Adressierung komplexer wird
	* Chipfläche ist begrenzt

### Cache Assoziativität

* Direkt abgebildeter Cache

Jeder Speicherblock kann in genau einem Blockrahmen abgelegt werden

* Mengen-assoziativer Cache

Jeder Speicherblock kann in einer festgelegten Anzahl von Blockrahmen abgelegt werden

* Voll-assoziativer Cache

Jeder Speicherblock kann in einem beliebigen Blockrahmen abgelegt werden

Ersetzungsmethoden für Mengen- und Vollassoziative Caches
* LRU *least recently used* -> Das älteste fliegt
* LFU *least frequently used* -> Das am wenigsten benutzte fliegt

### Cache Rückschreibestrategien

#### Write through

* Einträge in Cache und RAM weden geändert => "Durchschreiben"
* Alle Prozessoren sehen sofort den aktuellen Wert
* Schreiben dauert lange, da in RAM geschrieben werden muss
* Direkte IO Operationen auf RAM möglich

#### Write back

* Eintrag wird "erstmal" nur im Cache geändert
* Cache und RAM laufen auseinander -> Cache ist aktueller
* Dirty-Bit zeigt an, ob Speicherblock modifiziert wurde

### Cache Kohärenz

[Wikipedia - Cache coherence](http://en.wikipedia.org/wiki/Cache_coherence)

* Stellt sicher, dass Prozessoren mit korrekten Werten arbeiten
* Cache ist _kohärent_, wenn für jede Speicherzelle gilt, dass jede Leseoperation den letzten geschriebenen Wert zurückliefert
* 2 Gruppen von Protokollen
	* Verzeichnis-basiert

Zentrale Liste

	* Snooping-basiert

CC beobachtet Bus/Switch (Medium für gemeinsamen Speicherzugriff)


#### Modified-Shared-Invalid (MSI)

* Annahme: Write-Back Strategie
* Drei Zustände für Cacheblock
	* Modified *dirty*
	
Block ist verändert, nur ein Cache hat die aktuelle Version.
	
	* Shared *clean*
	
Block ist in einem oder mehreren Caches in gleichem Zustand gespeichert.
	
	* Invalid
	
Block hat ungültigen (veralteten) Wert.

* MSI-Prozessor-Events
	* PrRd (read)
	
**Leseoperation** eines Prozessors auf einem Speicherblock
	
	* PrWr (write)

**Schreiboperation** eines Prozessors auf einem Speicherblock

	* BusRd (Bus Read)
	
Prozessor will **Leseoperation** auf einem Speicherblock durchführen

	* BusRdEx (Bus Read Exclusive)
	
**Schreiboperation** auf Block der nicht im Cache ist oder nicht **modifiziert** wurde. Alle anderen Kopien werden als **invalid** markiert.
Achtung: Hat "Read" im Namen, aber verändert den Wert!

	* Flush
	
Update des RAM, Wert wird über Bus an auslösenden Cache übertragen



#### Modified-Exclusive-Invalid (MESI)

* Erweiterung von MSI
* Weiterer Zustand
	* Exclusive *clean*
	
Nur der betrachtete Cache hält eine Kopie des Speicherblocks.

* Bus-Operationen
	* Gleiche wie MSI
	* BusUpgr (Prozessor will Schreiboperation auf einem Speicherblock ausführen, der bereits in einem anderen Cache ist.)
	* FlushOpt (cache-to-cache) (Block wird über Bus von Cache A nach Cache B übertragen. Dieses Feature ist optional und wird nicht für korrektes Arbeiten benötigt.)

Wie wird entschieden ob von **Invalid** nach **Exclusive** oder **Shared** gewechselt wird? -> Es muss geprüft werden, ob schon jemand eine Kopie besitzt und dies mit Signal auf dem Bus signalisiert werden.



#### Modified-Owner-Exclusive (MOESI)

* Weiterer Zustand
	* Owner *dirty*
	
Kopie des Blocks in anderen Caches, aber **Owner** ist verantwortlich, Daten zur Verfügung zu stellen, wenn er entsprechende Busoperationen sieht.

#### Dragon Writeback Update

* 4 Zustände
	* (E) Exclusive-clean (Cache und RAM besitzen Wert.)
	* (Sc) Shared-clean (Aktueller Cache und andere Caches (und möglicherweise RAM) besitzen den Wert. Aktueller Cache ist nicht **Owner**.)
	* (Sm) Shared-modified (Aktueller Cache und andere Caches (nicht der RAM) besitzen den Wert. Aktueller Cache ist **Owner**.)
	* (M) Modified *dirty* (Nur aktueller Cache besitzt den Wert.)


## SIMD



# 5 Performance

## Performance Modellierung

### PRAM (Parallel Random Access Machine)

[Wikipedia ](http://de.wikipedia.org/wiki/Parallel_Random_Access_Machine)

### BSP (Bulk Synchronous Parallel)

[Wikipedia](https://en.wikipedia.org/wiki/Bulk_synchronous_parallel)

### LogP (Latency Overhead Gap Processors)

### Timing Modell von Van de Velde

Buch von van de Velde [Concurrent Scientific Computing](http://www.springer.com/mathematics/analysis/book/978-0-387-94195-0) (Leider nicht über SpringerLink erhältlich)


#### Zeit für Datenaustausch

| Variable | Bedeutung |
| ----- | ----- |
| $t_{K}$ | Kommunikationszeit | 
| $t_{S}$ | Initialisierungszeit |
| $\beta$ | Bandbreite (Kehrwert) |
| $L$ | Länge der Nachricht |

$t_{K} = t_{S} + \beta * L$

#### Zeit für sequentielle Ausführung

| Variable | Bedeutung |
| ----- | ----- |
| $T_{s}$ | Sequentielle Rechenzeit |
| $o$ | Anzahl (arithm.) Operationen |
| $N$ | Schleifenlänge |
| $t_{a}$ | Zeit für eine Operation |

$T_{s} = o * N * t_{a} $

#### Zeit für parallele Ausführung

| Variable | Bedeutung |
| ----- | ----- |
| $T_{p}$ | Parallele Rechenzeit |
| $o$ | Anzahl (arithm.) Operationen |
| $\hat{N}$ | Ideal: $\frac{N}{p}$ Sonst: Längste Schleife eines Prozessors (P teilen Schleife auf) |
| $t_{a}$ | Zeit für eine Operation |

$T_{p} = o * \hat{N} * t_{a} $

# 6 Errors

## Fehlerklassen

### Race Condition

* Kann als "zeitkritischer Ablauf" übersetzt werden
* Ergebnisse eines nebenläufigen Programms sind verändert wegen
	* Unterschiedlich schneller Bearbeitung
	* Andere Bearbeitungsreihenfolge

### Deadlock

* Prozesse warten aufeinander
* Programm "bleibt stehen"

### Dirty Read

* Auch "uncommited Read"
* Ein Prozess nutzt ein Zwischenergebnis eines andren Prozesses, ohne auf Bestätigung zu warten
* Es wird mit falschen Daten gearbeitet

### Non-Repeatable Read

* Zwei mal gleiche Anfrage lesen gibt zwei unterschiedliche Ergebnisse
* Beispiel online Ticket kauf: Tickets anzeigen (n verfügbar), lange nachdenken, tickets werden ausverkauft, Tickets anzeigen (0 verfügbar)

### Lost Update

* Zwei Prozesse schreiben gleiche Stelle: Wert von P1 geht verloren, P2 gewinnt

## Werkzeugkasten

### Kritischer Bereich

### Atomare Operation

### Sperrmechanismen

* Semaphor

* Mutex

### Monitor

### Barriere

### Message Passing

# 7 Networks

## Metriken

### Durchmesser

Der längste kürzeste Pfad.

Typische Anforderung: Kleiner Wert (Kurze Distanzen)

### Grad

Die meißten Kanten an einem Knoten.

Typische Anforderung: Kleiner Wert (Wenig Hardware benötigt => günstig)

### Bisektionsbandbreite

Die kleinste Anzahl Kanten die gekappt werden muss um zwei (annähernd) gleich große Netze zu erstellen.

Typische Anforderung: Großer Wert (Hohe Bandbreite)

### Konnektivität

Die kleinste Anzahl Kanten die gekappt werden muss um das Netz in zwei Teile zu zerlegen.

Typische Anforderung: Großer Wert (Hohe Zuverlässigkeit)


# 8 GPU / OpenCl

## Begriffe

### Datenparallelität

Jeder Pixel kann unabhängig von seinen Nachbarn berechnet werden -> Keine Abhängigkeiten

### OpenCl-Device

Ein Prozessor, der datenparallele Programme ausführt.

### Kernel

Eine datenparallele Funktion, die auf einem Device ausgeführt wird.
 

# 9 Patterns


### Master-Worker

Master verteilt Arbeit an Worker, sammelt Ergebnisse ein, persistiert Daten

### Pipeline

|input| -> |cpu| -> |cpu| -> |cpu| -> |cpu| -> |output|

### MapReduce / Replicable

In Verwendung bei Google, Facebook, ..

#### Map Schritt

#### Reduce Schritt

### Job Pool / Task Queue / Repository

### Thread Pool

## Designziele

### Effizienz

* Resources gut nutzen
* Overhead kennen

### Einfachheit

* Debug, Verifizierung und Wartung wird einfacher

### Portabilität

* Läuft auf shared und distributed memory

### Skalierbarkeit

