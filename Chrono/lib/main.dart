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
