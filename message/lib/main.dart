import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR');
  runApp(const TicketSportApp());
}

class TicketSportApp extends StatelessWidget {
  const TicketSportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tickets Sportifs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B00),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B1B1B),
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const ListeMatchsScreen(),
    );
  }
}

class MatchSportif {
  const MatchSportif({
    required this.imageUrl,
    required this.equipeDomicile,
    required this.equipeExterieur,
    required this.date,
    required this.prixFcfa,
    required this.stade,
  });

  final String imageUrl;
  final String equipeDomicile;
  final String equipeExterieur;
  final DateTime date;
  final int prixFcfa;
  final String stade;
}

final List<MatchSportif> matchs = [
  MatchSportif(
    imageUrl:
        'https://images.unsplash.com/photo-1575361204480-aadea25e6e68?auto=format&fit=crop&w=1200&q=80',
    equipeDomicile: 'Lions de Dakar',
    equipeExterieur: 'Étoile de Thiès',
    date: DateTime(2026, 4, 12, 19, 30),
    prixFcfa: 5000,
    stade: 'Stade Léopold Sédar Senghor',
  ),
  MatchSportif(
    imageUrl:
        'https://images.unsplash.com/photo-1518604666860-9ed391f76460?auto=format&fit=crop&w=1200&q=80',
    equipeDomicile: 'AS Abidjan',
    equipeExterieur: 'FC Yamoussoukro',
    date: DateTime(2026, 4, 20, 18, 0),
    prixFcfa: 7500,
    stade: 'Stade Félix Houphouët-Boigny',
  ),
  MatchSportif(
    imageUrl:
        'https://images.unsplash.com/photo-1508098682722-e99c643e7485?auto=format&fit=crop&w=1200&q=80',
    equipeDomicile: 'Union Bamako',
    equipeExterieur: 'Real Sikasso',
    date: DateTime(2026, 5, 2, 20, 15),
    prixFcfa: 6000,
    stade: 'Stade du 26 Mars',
  ),
];

final NumberFormat formatPrix = NumberFormat.currency(
  locale: 'fr_FR',
  symbol: 'FCFA',
  decimalDigits: 0,
);

final DateFormat formatDate = DateFormat('EEEE d MMMM y à HH:mm', 'fr_FR');

class ListeMatchsScreen extends StatelessWidget {
  const ListeMatchsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Matchs disponibles')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: matchs.length,
        itemBuilder: (context, index) {
          final match = matchs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailMatchScreen(match: match),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      match.imageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${match.equipeDomicile} vs ${match.equipeExterieur}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          formatDate.format(match.date),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          formatPrix.format(match.prixFcfa),
                          style: const TextStyle(
                            color: Color(0xFFFF6B00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailMatchScreen extends StatelessWidget {
  const DetailMatchScreen({super.key, required this.match});

  final MatchSportif match;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail du match')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              match.imageUrl,
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${match.equipeDomicile} vs ${match.equipeExterieur}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text('Date : ${formatDate.format(match.date)}'),
                  const SizedBox(height: 8),
                  Text('Stade : ${match.stade}'),
                  const SizedBox(height: 8),
                  Text(
                    'Prix : ${formatPrix.format(match.prixFcfa)}',
                    style: const TextStyle(
                      color: Color(0xFFFF6B00),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MonTicketScreen(match: match),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B00),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.confirmation_num),
                      label: const Text('Acheter le ticket'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonTicketScreen extends StatelessWidget {
  const MonTicketScreen({super.key, required this.match});

  final MatchSportif match;

  @override
  Widget build(BuildContext context) {
    final qrData =
        'Ticket|${match.equipeDomicile}|${match.equipeExterieur}|${match.date.toIso8601String()}|${match.prixFcfa}';

    return Scaffold(
      appBar: AppBar(title: const Text('Mon ticket')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${match.equipeDomicile} vs ${match.equipeExterieur}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(formatDate.format(match.date), textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(match.stade, textAlign: TextAlign.center),
                const SizedBox(height: 14),
                Text(
                  formatPrix.format(match.prixFcfa),
                  style: const TextStyle(
                    color: Color(0xFFFF6B00),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                QrImageView(
                  data: qrData,
                  size: 220,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 12),
                const Text('Présentez ce QR Code à l’entrée'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
