import 'counter_model.dart';

class CounterBloc {
  final CounterModel _counter = CounterModel(0);

  int get currentValue => _counter.value;

  void increment() {
    _counter.increment();
    // Notificar a los oyentes (en caso de usar un sistema de gestión de estado)
  }

  void decrement() {
    _counter.decrement();
    // Notificar a los oyentes
  }
}
