Descrizione del progetto

zKeep è una semplice applicazione Flutter ispirata a Google Keep.
L’app permette di creare più note sotto forma di card.
Ogni card può contenere un titolo e una lista di promemoria (todo).

L’utente può:

creare una nuova nota
modificare il titolo della nota
aggiungere righe di testo
spuntare una riga come completata
eliminare una singola riga
eliminare una nota intera
Tutti i dati vengono salvati in locale tramite SQLite, quindi le note restano memorizzate anche dopo la chiusura dell’app.

Componenti del progetto

main.dart

Contiene l’avvio dell’applicazione.
Imposta il ChangeNotifierProvider, carica i dati iniziali dal database e mostra la schermata principale.

model.dart

Contiene i modelli dei dati:

TodoCard: rappresenta una nota
TodoLine: rappresenta una singola riga della nota
helper.dart

Gestisce il database SQLite.
Si occupa di:

creare il database
creare le tabelle
leggere le note
inserire nuove card e nuove righe
aggiornare titolo e righe
eliminare righe e card
notifier.dart

Contiene la logica dell’applicazione tramite ChangeNotifier.
Gestisce la lista delle note e aggiorna l’interfaccia quando i dati cambiano.

widgets.dart

Contiene i widget principali dell’interfaccia:

TodoCardWidget per mostrare una nota nella griglia
EditNoteScreen per modificare una nota
Struttura del database

L’app usa due tabelle:

cards

Contiene le note:

id
title
lines

Contiene le righe di ogni nota:

id
card_id
text
checked
Ogni riga è collegata a una card tramite card_id.

Logica e funzionamento

All’avvio dell’app il notifier carica tutte le note salvate nel database.
La schermata principale mostra le note in una griglia a due colonne.

Quando l’utente preme il pulsante Nuova:

viene creata una nuova card nel database
la card viene aggiunta alla lista
si apre subito la schermata di modifica
Nella schermata di modifica l’utente può:

scrivere o modificare il titolo
aggiungere nuove righe
modificare il testo di ogni riga
spuntare una riga come completata
eliminare una riga
eliminare tutta la nota
Ogni modifica viene salvata nel database e l’interfaccia si aggiorna automaticamente grazie a Provider e ChangeNotifier.

Scelte di sviluppo

Ho scelto di usare Flutter perché permette di sviluppare in modo semplice un’app mobile con una sola base di codice.

Ho usato Provider con ChangeNotifierperché è una soluzione semplice e adatta a un progetto scolastico per gestire lo stato dell’app.

Ho usato SQLite perché i dati delle note devono restare salvati anche quando l’app viene chiusa.

Ho scelto una struttura con:

model per i dati
helper per il database
notifier per la logica
widgets per l’interfaccia
In questo modo il progetto è più ordinato e il codice è più facile da capire.

Interfaccia grafica

L’interfaccia è semplice e ispirata a Google Keep:

home con griglia di card
pulsante per aggiungere una nuova nota
schermata dedicata alla modifica della nota
checkbox per segnare i promemoria completati
Pacchetti usati

provider
sqflite
path
flutter_staggered_grid_view





