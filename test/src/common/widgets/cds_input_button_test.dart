import 'package:demoafgr/demoafgr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'CdsInputButton Widget Tests',
    () {
      testWidgets(
        'Renders TextField and IconButton with correct initial states',
        (final tester) async {
          final controller = TextEditingController();

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: CdsInputButton(
                  controller: controller,
                  onPressed: () {},
                ),
              ),
            ),
          );

          expect(find.byType(TextField), findsOneWidget);
          expect(find.byType(IconButton), findsOneWidget);

          expect(find.text('https://'), findsOneWidget);
        },
      );

      testWidgets(
        'Text input changes are reflected in the controller',
        (final tester) async {
          final controller = TextEditingController();

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: CdsInputButton(
                  controller: controller,
                  onPressed: () {},
                ),
              ),
            ),
          );

          await tester.enterText(find.byType(TextField), 'https://example.com');
          await tester.pump();

          expect(controller.text, 'https://example.com');
        },
      );

      testWidgets(
        'onPressed callback is called when button is pressed',
        (final tester) async {
          var pressed = false;
          final controller = TextEditingController();

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: CdsInputButton(
                  controller: controller,
                  onPressed: () => pressed = true,
                ),
              ),
            ),
          );

          await tester.tap(find.byType(IconButton));
          await tester.pump();

          expect(pressed, isTrue);
        },
      );
    },
  );
}
