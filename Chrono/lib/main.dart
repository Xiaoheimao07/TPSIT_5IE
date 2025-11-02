class ChronoPage extends StatefulWidget {
  const ChronoPage({super.key});

  @override
  State<ChronoPage> createState() => _ChronoPageState();
}

class _ChronoPageState extends State<ChronoPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '00:00',
          style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
