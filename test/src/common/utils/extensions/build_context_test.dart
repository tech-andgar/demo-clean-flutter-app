import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks.dart';
import '../../../pre_main.dart';

Future<void> main() async {
  await preMainTest();
  group('BuildContext extension -', () {
    tearDown(() {
      theme_ = null;
    });
    testWidgets(
      'check type theme',
      (WidgetTester tester) async {
        // Act
        await tester.pumpWidget(MockBase.appTest());
        await tester.pump();

        // Assert
        final ThemeData theme = theme_!;
        expect(theme, isA<ThemeData>());
        expect(theme.useMaterial3, true);
      },
    );
  });
}
