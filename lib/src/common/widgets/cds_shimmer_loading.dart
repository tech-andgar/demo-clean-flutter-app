import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/core.dart';
import '../common.dart';

class CdsShimmerLoading extends StatelessWidget {
  CdsShimmerLoading({
    required this.width,
    required this.height,
    super.key,
  }) : decoration = BoxDecoration(
          color: Colors.white,
          borderRadius: Constants.borderRadius,
        );

  CdsShimmerLoading.rectangular({
    required this.width,
    required this.height,
    super.key,
    final ShapeBorder? shape = const RoundedRectangleBorder(),
  }) : decoration = ShapeDecoration(
          color: Colors.white,
          shape: shape!,
        );

  const CdsShimmerLoading.circular({
    required final double size,
    super.key,
  })  : width = size,
        height = size,
        decoration = const ShapeDecoration(
          color: Colors.white,
          shape: OvalBorder(),
        );

  const CdsShimmerLoading.square({
    required final double size,
    this.decoration,
    super.key,
  })  : width = size,
        height = size;

  final double height;
  final Decoration? decoration;
  final double width;

  @override
  Widget build(final BuildContext context) {
    final colorOutline = context.theme.colorScheme.outline;

    return Shimmer.fromColors(
      baseColor: colorOutline.withAlpha(26),
      highlightColor: colorOutline.withAlpha(77),
      child: Container(
        height: height,
        width: width,
        decoration: decoration,
      ),
    );
  }
}
