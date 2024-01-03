import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks.dart';

void main() {
  group('BuildContext extension -', () {
    testWidgets(
      'check type theme',
      (WidgetTester tester) async {
        // Arrange
        const DemoWidget widgetDemo = DemoWidget();

        // Act
        await tester.pumpWidget(MockBase.appTest(widgetDemo));

        // Assert
        final ThemeData theme = DemoWidget.theme;
        expect(theme, isA<ThemeData>());
        expect(theme.useMaterial3, true);
      },
    );
  });
}
