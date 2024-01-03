import 'package:demoafgr/demoafgr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CdsListInitialLoading Widget Tests', () {
    testWidgets('Renders a column with 10 CdsItemLoading children',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CdsListInitialLoading(),
          ),
        ),
      );

      expect(find.byType(Column).first, findsOneWidget);

      expect(find.byType(CdsItemLoading), findsNWidgets(10));
    });
  });
}
