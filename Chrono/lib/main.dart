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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chrono')),
      body: Center(
        child: Text(
          '$secondi',
          style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
