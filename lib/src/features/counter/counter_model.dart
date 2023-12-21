class CounterModel {
  CounterModel(this.value);

  int value;

  void increment() => value++;

  void decrement() => value--;

	@override
	String toString() => 'CounterModel(value: $value)';
}
