import 'package:demonu/demonu.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CounterBloc bloc;

  setUp(() {
    bloc = CounterBloc();
  });

  test('Initial value is 0', () {
    expect(bloc.currentValue, 0);
  });

  test('Increment increases value by 1', () {
    bloc.increment();
    expect(bloc.currentValue, 1);
  });

  test('Decrement decreases value by 1', () {
    bloc.increment();
    bloc.decrement();
    expect(bloc.currentValue, 0);
  });
}
