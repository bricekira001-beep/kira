import 'package:flutter/material.dart';

// Point d'entrée de l'application.
void main() {
  runApp(const CalculatriceApp());
}

// Widget racine de l'application.
class CalculatriceApp extends StatelessWidget {
  const CalculatriceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculatrice Flutter',
      // Thème global pour donner un style moderne et coloré.
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6D28D9),
          brightness: Brightness.dark,
        ),
      ),
      home: const CalculatricePage(),
    );
  }
}

// Page principale de la calculatrice.
class CalculatricePage extends StatefulWidget {
  const CalculatricePage({super.key});

  @override
  State<CalculatricePage> createState() => _CalculatricePageState();
}

// État de la page : on y gère les valeurs affichées et les calculs.
class _CalculatricePageState extends State<CalculatricePage> {
  // Texte affiché en haut (nombre saisi et résultat).
  String _display = '0';

  // Premier nombre de l'opération (ex: dans 8 + 2, c'est 8).
  double? _premierNombre;

  // Opérateur choisi (+, -, ×, ÷).
  String? _operateur;

  // Indique si on doit remplacer l'affichage au prochain chiffre tapé.
  bool _remplacerDisplay = false;

  // Gère les appuis sur les chiffres (0 à 9).
  void _appuyerChiffre(String chiffre) {
    setState(() {
      if (_display == '0' || _remplacerDisplay) {
        _display = chiffre;
        _remplacerDisplay = false;
      } else {
        _display += chiffre;
      }
    });
  }

  // Gère les appuis sur les opérateurs (+, -, ×, ÷).
  void _appuyerOperateur(String op) {
    setState(() {
      _premierNombre = double.tryParse(_display);
      _operateur = op;
      _remplacerDisplay = true;
    });
  }

  // Réinitialise totalement la calculatrice.
  void _effacerTout() {
    setState(() {
      _display = '0';
      _premierNombre = null;
      _operateur = null;
      _remplacerDisplay = false;
    });
  }

  // Calcule le résultat quand on appuie sur '='.
  void _calculerResultat() {
    if (_premierNombre == null || _operateur == null) {
      return;
    }

    final double? deuxiemeNombre = double.tryParse(_display);
    if (deuxiemeNombre == null) {
      return;
    }

    double resultat;

    switch (_operateur) {
      case '+':
        resultat = _premierNombre! + deuxiemeNombre;
        break;
      case '-':
        resultat = _premierNombre! - deuxiemeNombre;
        break;
      case '×':
        resultat = _premierNombre! * deuxiemeNombre;
        break;
      case '÷':
        if (deuxiemeNombre == 0) {
          setState(() {
            _display = 'Erreur';
            _premierNombre = null;
            _operateur = null;
            _remplacerDisplay = true;
          });
          return;
        }
        resultat = _premierNombre! / deuxiemeNombre;
        break;
      default:
        return;
    }

    setState(() {
      // Si le résultat est entier, on n'affiche pas les décimales inutiles.
      if (resultat == resultat.toInt()) {
        _display = resultat.toInt().toString();
      } else {
        _display = resultat.toString();
      }

      _premierNombre = null;
      _operateur = null;
      _remplacerDisplay = true;
    });
  }

  // Construit un bouton avec un style réutilisable.
  Widget _buildBouton({
    required String texte,
    required VoidCallback onPressed,
    Color? couleur,
    Color? couleurTexte,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: couleur ?? const Color(0xFF1F2937),
          foregroundColor: couleurTexte ?? Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 4,
        ),
        child: Text(
          texte,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond dégradé pour un design moderne.
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF111827), Color(0xFF4C1D95)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Zone d'affichage des nombres saisis et du résultat.
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _display,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 52,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                // Grille de boutons de la calculatrice.
                Expanded(
                  flex: 2,
                  child: GridView.count(
                    crossAxisCount: 4,
                    childAspectRatio: 1.05,
                    children: [
                      _buildBouton(
                        texte: 'C',
                        couleur: const Color(0xFFEF4444),
                        onPressed: _effacerTout,
                      ),
                      _buildBouton(texte: '÷', onPressed: () => _appuyerOperateur('÷')),
                      _buildBouton(texte: '×', onPressed: () => _appuyerOperateur('×')),
                      _buildBouton(texte: '-', onPressed: () => _appuyerOperateur('-')),
                      _buildBouton(texte: '7', onPressed: () => _appuyerChiffre('7')),
                      _buildBouton(texte: '8', onPressed: () => _appuyerChiffre('8')),
                      _buildBouton(texte: '9', onPressed: () => _appuyerChiffre('9')),
                      _buildBouton(texte: '+', onPressed: () => _appuyerOperateur('+')),
                      _buildBouton(texte: '4', onPressed: () => _appuyerChiffre('4')),
                      _buildBouton(texte: '5', onPressed: () => _appuyerChiffre('5')),
                      _buildBouton(texte: '6', onPressed: () => _appuyerChiffre('6')),
                      _buildBouton(
                        texte: '=',
                        couleur: const Color(0xFF10B981),
                        onPressed: _calculerResultat,
                      ),
                      _buildBouton(texte: '1', onPressed: () => _appuyerChiffre('1')),
                      _buildBouton(texte: '2', onPressed: () => _appuyerChiffre('2')),
                      _buildBouton(texte: '3', onPressed: () => _appuyerChiffre('3')),
                      _buildBouton(texte: '0', onPressed: () => _appuyerChiffre('0')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
