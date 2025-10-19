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
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
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
