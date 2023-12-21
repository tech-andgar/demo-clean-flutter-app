import 'package:flutter/material.dart';

import '../../common/common.dart';
import 'counter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key, required this.counterBloc});

  final CounterBloc counterBloc;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '${widget.counterBloc.currentValue}',
              style: theme.textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => widget.counterBloc.increment(),
                  child: const Text('Increment'),
                ),
                ElevatedButton(
                  onPressed: () => widget.counterBloc.decrement(),
                  child: const Text('Decrement'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
