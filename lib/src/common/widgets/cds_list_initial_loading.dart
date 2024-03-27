import 'package:flutter/material.dart';

import 'widgets.dart';

class CdsListInitialLoading extends StatelessWidget {
  const CdsListInitialLoading({super.key});

  @override
  Widget build(final BuildContext context) => Column(
        children: List<Widget>.generate(10, (final _) => const CdsItemLoading()),
      );
}
