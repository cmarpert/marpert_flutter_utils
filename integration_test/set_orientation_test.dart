import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app_for_integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding();

  testWidgets('Change orientation to landscape', (tester) async {
    await tester.pumpWidget(MyApp());

    final orientationButton = find.byKey(const Key('orientationButton'));

    await tester.tap(orientationButton);

    // Pump the widget tree to rebuild it with the new orientation
    await tester.pumpAndSettle();

    expect(MediaQuery.of(tester.element(find.byType(MyApp))).orientation, Orientation.landscape);
  });
}
