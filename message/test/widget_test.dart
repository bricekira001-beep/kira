import 'package:flutter_test/flutter_test.dart';

import 'package:message/main.dart';

void main() {
  testWidgets('Affiche le message quand on clique sur le bouton', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AppDebutant());

    expect(find.text('Bienvenue sur ton app Flutter 🎉'), findsOneWidget);
    expect(find.text('Bravo ! Tu as cliqué sur le bouton 👏'), findsNothing);

    await tester.tap(find.text('Afficher le message'));
    await tester.pump();

    expect(find.text('Bravo ! Tu as cliqué sur le bouton 👏'), findsOneWidget);
  });
}
