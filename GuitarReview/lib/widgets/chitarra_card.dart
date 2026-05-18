import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model.dart';
import '../notifier.dart';
import 'stelle_widget.dart';
import 'carat_chip.dart';
import 'form_preferito_screen.dart';

class ChitarraCard extends StatelessWidget {
  const ChitarraCard({super.key, required this.chitarra});

  final Chitarra chitarra;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ChitarreNotifier>();
    final preferito = notifier.preferitoPer(chitarra.id);
    final isFavorito = preferito != null;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_iconaTipo(chitarra.tipo),
                    style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chitarra.nome,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(
                        '${chitarra.tipo.toUpperCase()}  ·  ${chitarra.marca}',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorito ? Icons.favorite : Icons.favorite_border,
                    color: isFavorito ? Colors.red : Colors.grey,
                    size: 28,
                  ),
                  tooltip: isFavorito
                      ? 'Rimuovi dai preferiti'
                      : 'Aggiungi ai preferiti',
                  onPressed: notifier.isOffline
                      ? null
                      : () => _gestisciPreferito(context, notifier, preferito),
                ),
              ],
            ),
            const SizedBox(height: 10),
            StelleWidget(voto: chitarra.stelle),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                CaratChip(icon: Icons.queue_music, label: '${chitarra.corde} corde'),
                if (chitarra.custodia)
                  const CaratChip(icon: Icons.cases, label: 'Custodia'),
                if (chitarra.amplificatore)
                  const CaratChip(icon: Icons.speaker, label: 'Amplificatore'),
                if (chitarra.accordatore)
                  const CaratChip(icon: Icons.tune, label: 'Accordatore'),
                if (chitarra.mancina)
                  const CaratChip(icon: Icons.back_hand, label: 'Mancina'),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              chitarra.descrizione,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  String _iconaTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'elettrica':  return '🎸';
      case 'acustica':   return '🪕';
      case 'classica':   return '🎼';
      case 'basso':      return '🎵';
      default:           return '🎶';
    }
  }

  Future<void> _gestisciPreferito(BuildContext context,
      ChitarreNotifier notifier, Preferito? esistente) async {
    if (esistente == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FormPreferitoScreen(chitarraId: chitarra.id),
        ),
      );
    } else {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Rimuovi dai preferiti'),
          content: Text(
              'Vuoi rimuovere "${chitarra.nome}" dai tuoi preferiti?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Annulla')),
            TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Rimuovi',
                    style: TextStyle(color: Colors.red))),
          ],
        ),
      );
      if (ok == true) {
        try {
          await notifier.deletePreferito(esistente.id!);
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Errore: $e')),
            );
          }
        }
      }
    }
  }
}