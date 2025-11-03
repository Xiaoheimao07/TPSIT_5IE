import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const Chrono());
}

class Chrono extends StatelessWidget {
  const Chrono({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChronoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChronoPage extends StatefulWidget {
  const ChronoPage({super.key});

  @override
  State<ChronoPage> createState() => _ChronoPageState();
}

class _ChronoPageState extends State<ChronoPage> {
  StreamSubscription<int>? tickerSubscription;
  int secondi = 0;
  bool contatore = false;
  bool statoPausa = false;

  void start() {
    tickerSubscription?.cancel();
    tickerSubscription =
        Stream.periodic(const Duration(milliseconds: 100), (x) => x)
            .listen((evento) {
      if (evento % 10 == 0) {
        setState(() {
          secondi++;
        });
      }
    });
    setState(() {
      contatore = true;
      statoPausa = false;
    });
  }

  void stop() {
    tickerSubscription?.cancel();
    setState(() {
      contatore = false;
      statoPausa = false;
    });
  }

  void reset() {
    tickerSubscription?.cancel();
    setState(() {
      secondi = 0;
      contatore = false;
      statoPausa = false;
    });
  }

  void pause() {
    tickerSubscription?.pause();
    setState(() {
      statoPausa = true;
    });
  }

  void resume() {
    tickerSubscription?.resume();
    setState(() {
      statoPausa = false;
    });
  }

  String cambioFormato(int secondi) {
    final minuti = secondi ~/ 60;
    final secondiRimanenti = secondi % 60;
    return '${minuti.toString().padLeft(2, '0')}:${secondiRimanenti.toString().padLeft(2, '0')}';
  }

  @override
  void cancellazione() {
    tickerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chrono'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          cambioFormato(secondi),
          style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: FloatingActionButton(
                heroTag: 'main',
                backgroundColor: Colors.purple,
                onPressed: () {
                  if (!contatore && secondi == 0) {
                    start();
                  } else if (contatore) {
                    stop();
                  } else if (!contatore && secondi > 0) {
                    reset();
                  }
                },
                child: Icon(
                  !contatore && secondi == 0
                      ? Icons.play_arrow
                      : contatore
                          ? Icons.stop
                          : Icons.refresh,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: FloatingActionButton(
                heroTag: 'pause',
                backgroundColor: Colors.green,
                onPressed: () {
                  if (contatore && !statoPausa) {
                    pause();
                  } else if (statoPausa) {
                    resume();
                  }
                },
                child: Icon(
                  statoPausa ? Icons.play_arrow : Icons.pause,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
