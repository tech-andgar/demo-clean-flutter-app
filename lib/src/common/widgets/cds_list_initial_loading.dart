import 'package:flutter/material.dart';

import 'widgets.dart';

class CdsListInitialLoading extends StatelessWidget {
  const CdsListInitialLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(10, (_) => const CdsItemLoading()),
    );
  }
}
