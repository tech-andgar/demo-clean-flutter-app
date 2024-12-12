import 'package:demoafgr/demoafgr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CdsSnackBar Tests', () {
    testWidgets(
      'Shows a SnackBar with the correct message',
      (final tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (final context) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () =>
                          CdsSnackBar.show(context, 'Test Message'),
                      child: const Text('Show SnackBar'),
                    ),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Test Message'), findsOneWidget);
      },
    );
  });
}
