import 'package:demoafgr/demoafgr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CdsItemLoading Widget Tests', () {
    testWidgets(
      'Renders correctly with expected layout and children',
      (final tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CdsItemLoading(),
            ),
          ),
        );

        expect(
          tester.widget<Padding>(find.byType(Padding).first).padding,
          const EdgeInsets.symmetric(horizontal: 16.0),
        );

        expect(
          tester.widget<Column>(find.byType(Column)).crossAxisAlignment,
          CrossAxisAlignment.start,
        );

        final shimmerFinders = find
            .byType(CdsShimmerLoading)
            .evaluate()
            .map((final e) => find.byWidget(e.widget))
            .toList();
        expect(shimmerFinders.length, 2);

        final firstShimmerSize = tester.getSize(shimmerFinders[0]);
        expect(
          firstShimmerSize,
          equals(const Size(400, 16)),
        );

        final secondShimmerSize = tester.getSize(shimmerFinders[1]);
        expect(
          secondShimmerSize,
          equals(const Size(300, 16)),
        );
      },
    );
  });
}
