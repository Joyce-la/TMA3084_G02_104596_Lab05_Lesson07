import 'package:flutter_test/flutter_test.dart';
import 'package:lab_b/main.dart';

void main() {
  testWidgets('DataTable displays all column headings', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DataTableLab());

    expect(find.text('Car Make'), findsOneWidget);
    expect(find.text('Model'), findsOneWidget);
    expect(find.text('Price'), findsOneWidget);
  });

  testWidgets('DataTable displays all cars by default', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DataTableLab());

    expect(find.text('Honda'), findsOneWidget);
    expect(find.text('Toyota'), findsOneWidget);
    expect(find.text('BMW'), findsOneWidget);
    expect(find.text('2021'), findsOneWidget);
    expect(find.text('2011'), findsOneWidget);
    expect(find.text('2010'), findsOneWidget);
  });

  testWidgets('Tapping Car Make sorts cars ascending', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DataTableLab());

    await tester.tap(find.text('Car Make'));
    await tester.pumpAndSettle();

    expect(
      tester.getTopLeft(find.text('BMW')).dy,
      lessThan(tester.getTopLeft(find.text('Honda')).dy),
    );

    expect(
      tester.getTopLeft(find.text('Honda')).dy,
      lessThan(tester.getTopLeft(find.text('Toyota')).dy),
    );
  });

  testWidgets('Tapping Model sorts cars ascending', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DataTableLab());

    await tester.tap(find.text('Model'));
    await tester.pumpAndSettle();

    expect(
      tester.getTopLeft(find.text('2010')).dy,
      lessThan(tester.getTopLeft(find.text('2011')).dy),
    );

    expect(
      tester.getTopLeft(find.text('2011')).dy,
      lessThan(tester.getTopLeft(find.text('2021')).dy),
    );
  });

  testWidgets('Tapping Price sorts cars ascending', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DataTableLab());

    await tester.tap(find.text('Price'));
    await tester.pumpAndSettle();

    expect(
      tester.getTopLeft(find.text('6000')).dy,
      lessThan(tester.getTopLeft(find.text('9000')).dy),
    );

    expect(
      tester.getTopLeft(find.text('9000')).dy,
      lessThan(tester.getTopLeft(find.text('35000')).dy),
    );
  });
}
