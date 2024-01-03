import 'package:flutter/material.dart';

import 'widgets.dart';

class CdsItemLoading extends StatelessWidget {
  const CdsItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 8),
          CdsShimmerLoading.rectangular(
            width: 400,
            height: 16,
          ),
          const SizedBox(height: 8),
          CdsShimmerLoading.rectangular(
            width: 300,
            height: 16,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
