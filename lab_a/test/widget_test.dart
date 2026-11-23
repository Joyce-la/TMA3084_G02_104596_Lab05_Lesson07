import 'package:flutter_test/flutter_test.dart';
import 'package:lab_a/main.dart';

void main() {
  testWidgets('Bottom navigation bar displays Home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BottomNavLab());

    expect(find.text('Home'), findsNWidgets(2));
    expect(find.text('Alarm'), findsOneWidget);
    expect(find.text('Business'), findsOneWidget);
    expect(find.text('School'), findsOneWidget);
  });

  testWidgets('Tapping Alarm displays Alarm screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BottomNavLab());

    await tester.tap(find.text('Alarm'));
    await tester.pumpAndSettle();

    expect(find.text('Alarm'), findsNWidgets(2));
  });

  testWidgets('Tapping Business displays Business screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BottomNavLab());

    await tester.tap(find.text('Business'));
    await tester.pumpAndSettle();

    expect(find.text('Business'), findsNWidgets(2));
  });

  testWidgets('Tapping School displays School screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BottomNavLab());

    await tester.tap(find.text('School'));
    await tester.pumpAndSettle();

    expect(find.text('School'), findsNWidgets(2));
  });
}
