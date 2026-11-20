import 'package:flutter_test/flutter_test.dart';

import 'package:lab5_lab_b/main.dart';

void main() {
  testWidgets('Car DataTable displays correctly', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Check the application title.
    expect(find.text('Car Information'), findsOneWidget);

    // Check the table column headings.
    expect(find.text('Car Make'), findsOneWidget);
    expect(find.text('Model'), findsOneWidget);
    expect(find.text('Price (RM)'), findsOneWidget);

    // Check that all five cars are displayed.
    expect(find.text('Honda'), findsOneWidget);
    expect(find.text('Toyota'), findsOneWidget);
    expect(find.text('Nissan'), findsOneWidget);
    expect(find.text('Perodua'), findsOneWidget);
    expect(find.text('Proton'), findsOneWidget);
  });

  testWidgets('Car Make can be sorted in ascending order', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap the Car Make column heading.
    await tester.tap(find.text('Car Make'));
    await tester.pumpAndSettle();

    // Verify the alphabetical order.
    final hondaY = tester.getTopLeft(find.text('Honda')).dy;
    final nissanY = tester.getTopLeft(find.text('Nissan')).dy;
    final peroduaY = tester.getTopLeft(find.text('Perodua')).dy;
    final protonY = tester.getTopLeft(find.text('Proton')).dy;
    final toyotaY = tester.getTopLeft(find.text('Toyota')).dy;

    expect(hondaY, lessThan(nissanY));
    expect(nissanY, lessThan(peroduaY));
    expect(peroduaY, lessThan(protonY));
    expect(protonY, lessThan(toyotaY));
  });
}
