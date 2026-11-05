import 'package:flutter_test/flutter_test.dart';

import 'package:hammerbonia/main.dart';

void main() {
  testWidgets('renders the Hammerbonia home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const HammerboniaApp());

    expect(find.text('HAMMERBONIA'), findsOneWidget);
    expect(find.text('Swing or shake your phone\nto hammer!'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('BONKS'), findsOneWidget);
  });
}
