import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/core.dart';
import '../common.dart';

class CdsShimmerLoading extends StatelessWidget {
  CdsShimmerLoading({
    super.key,
    required this.width,
    required this.height,
  }) : decoration = BoxDecoration(
          color: Colors.white,
          borderRadius: AppConstants.borderRadius,
        );

  CdsShimmerLoading.rectangular({
    required this.width,
    required this.height,
    super.key,
    ShapeBorder? shape = const RoundedRectangleBorder(),
  }) : decoration = ShapeDecoration(
          color: Colors.white,
          shape: shape!,
        );

  const CdsShimmerLoading.circular({
    required double size,
    super.key,
  })  : width = size,
        height = size,
        decoration = const ShapeDecoration(
          color: Colors.white,
          shape: OvalBorder(),
        );

  const CdsShimmerLoading.square({
    required double size,
    this.decoration,
    super.key,
  })  : width = size,
        height = size;

  final double height;
  //final ShapeBorder? shape;
  final Decoration? decoration;
  final double width;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;

    return Shimmer.fromColors(
      baseColor: theme.colorScheme.outline.withOpacity(.1),
      highlightColor: theme.colorScheme.outline.withOpacity(.3),
      child: Container(
        height: height,
        width: width,
        decoration: decoration,
      ),
    );
  }
}
