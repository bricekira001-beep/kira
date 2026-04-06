import 'package:flutter/material.dart';

void main() {
  runApp(const MonAppDebutant());
}

class MonAppDebutant extends StatelessWidget {
  const MonAppDebutant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application débutant',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        scaffoldBackgroundColor: const Color(0xFFF3F6FF),
        useMaterial3: true,
      ),
      home: const EcranAccueil(),
    );
  }
}

class EcranAccueil extends StatefulWidget {
  const EcranAccueil({super.key});

  @override
  State<EcranAccueil> createState() => _EcranAccueilState();
}

class _EcranAccueilState extends State<EcranAccueil> {
  String message = 'Appuie sur le bouton pour afficher un message.';

  void afficherMessage() {
    setState(() {
      message = 'Bravo 🎉 ! Tu as cliqué sur le bouton.';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Le bouton a bien été cliqué !'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil Flutter'),
        centerTitle: true,
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Color(0xFF1F2937)),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: afficherMessage,
                icon: const Icon(Icons.touch_app),
                label: const Text('Clique ici'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6584),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
