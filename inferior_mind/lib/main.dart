import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inferior Mind',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Inferior Mind'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Color> availableColori = [
    Colors.grey,//0
    Colors.red,//1

    Colors.orange,//2
    Colors.yellow, //3
    Colors.green,//4
    Colors.cyan,//5
    Colors.blue,//6
    Colors.purple,//7
  ];

  List<int> ordineColore = [0, 0, 0, 0];
  
  late List<int> codiceRisultato;

  @override
  void initState() {
    super.initState();
    _creatoreCodiceRisultato();
  }

  void _creatoreCodiceRisultato() {
    final random = Random();
    codiceRisultato = List.generate(4, (_) => 1 + random.nextInt(availableColori.length - 1));
    print('Codice Risultato : $codiceRisultato');
  }


  void _cicloColori(int index) {
    setState(() {
      ordineColore[index] =
          (ordineColore[index] + 1) % availableColori.length;
    });
  }

  void _controlloCorrettezza() {
    bool corretto = true;
    for (int i = 0; i < 4; i++) {
      if (ordineColore[i] != codiceRisultato[i]) {
        corretto = false;
        break;
      }
    }

  
ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          corretto ? 'LA COMBINAZIONE CORRETTA' : 'LA COMBINAZIONE È ERRATTA, RIPROVA ',
        ),
        duration: const Duration(seconds: 3),
      )
    );

    if (corretto) {
      _creatoreCodiceRisultato();
    }
    setState(() {
      ordineColore = [0, 0, 0, 0];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        shadowColor: Theme.of(context).shadowColor,
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Ti ga strucca el boton tante volte:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => _cicloColori(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: availableColori[ordineColore[index]],
                      minimumSize: const Size(75, 75),
                      shape: const CircleBorder(),
                       padding: EdgeInsets.zero, 
                    ),
                    child: const SizedBox.shrink(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
