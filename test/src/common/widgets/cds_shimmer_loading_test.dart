import 'package:demoafgr/demoafgr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  group('CdsShimmerLoading Widget Tests', () {
    testWidgets('Renders default CdsShimmerLoading with correct dimensions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CdsShimmerLoading(
              width: 100,
              height: 50,
            ),
          ),
        ),
      );

      final Finder containerFinder = find.byType(Container);
      expect(tester.getSize(containerFinder), equals(const Size(100, 50)));
    });

    testWidgets('Renders rectangular CdsShimmerLoading with correct shape',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CdsShimmerLoading.rectangular(
              width: 100,
              height: 50,
            ),
          ),
        ),
      );

      final Finder containerFinder = find.byType(Container);
      final Container container = tester.widget(containerFinder) as Container;
      expect(container.decoration, isA<ShapeDecoration>());
      expect(
        (container.decoration as ShapeDecoration).shape,
        isA<RoundedRectangleBorder>(),
      );
    });

    testWidgets('Renders circular CdsShimmerLoading with correct shape',
        (WidgetTester tester) async {
      const double size = 100;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CdsShimmerLoading.circular(
              size: size,
            ),
          ),
        ),
      );

      final Finder containerFinder = find.byType(Container);
      final Container container = tester.widget(containerFinder) as Container;
      expect(container.decoration, isA<ShapeDecoration>());
      expect(
        (container.decoration as ShapeDecoration).shape,
        isA<OvalBorder>(),
      );
    });

    testWidgets('Renders square CdsShimmerLoading with correct dimensions',
        (WidgetTester tester) async {
      const double size = 100;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CdsShimmerLoading.square(
              size: size,
            ),
          ),
        ),
      );

      final Finder containerFinder = find.byType(Container);
      expect(tester.getSize(containerFinder), equals(const Size(size, size)));
    });

    testWidgets('Uses theme colors correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              // Use a distinctive color for testing
              outline: Colors.red,
            ),
          ),
          home: Scaffold(
            body: CdsShimmerLoading(
              width: 100,
              height: 50,
            ),
          ),
        ),
      );

      final Finder shimmerFinder = find.byType(Shimmer);
      final Shimmer shimmer = tester.widget(shimmerFinder) as Shimmer;
      expect(shimmer.gradient.colors, [
        const Color(0x1af44336),
        const Color(0x1af44336),
        const Color(0x4df44336),
        const Color(0x1af44336),
        const Color(0x1af44336),
      ]);
      expect(shimmer.gradient.colors, [
        const Color(0x1af44336),
        const Color(0x1af44336),
        const Color(0x4df44336),
        const Color(0x1af44336),
        const Color(0x1af44336),
      ]);
    });
  });
}
