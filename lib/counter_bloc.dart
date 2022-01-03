import 'dart:async';

enum CounterAction { INCREASE, DECREASE, RESET }

class CounterBloc {
  late int counter;

  // 1. State StreamController
  final _stateStreamController = StreamController<int>();

  // Sink - Stream
  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  // 2. Event StreamController
  final _eventStreamController = StreamController<CounterAction>();

  // Sink - Stream
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  CounterBloc() {
    counter = 0;

    eventStream.listen((event) {
      if (event == CounterAction.INCREASE)
        counter++;
      else if (event == CounterAction.DECREASE)
        counter--;
      else if (event == CounterAction.RESET) counter = 0;

      // Passing event to state stream
      counterSink.add(counter);
    });
  }
}
