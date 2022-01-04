import 'dart:async';

enum CounterEvent { Increase, Decrease, Reset }

class CounterBloc {
  late int counter;

  // 1. State StreamController
  final _stateStreamController = StreamController<int>();
  // Create Sink - Stream
  StreamSink<int> get _counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  // 2. Event StreamController
  final _eventStreamController = StreamController<CounterEvent>();
  // Create Sink - Stream
  StreamSink<CounterEvent> get eventSink => _eventStreamController.sink;
  Stream<CounterEvent> get _eventStream => _eventStreamController.stream;

  CounterBloc() {
    _eventStream.listen((_mapEventToState));
  }

  _mapEventToState(CounterEvent event) {
    counter = 0;

    if (event == CounterEvent.Increase) {
      counter++;
    } else if (event == CounterEvent.Decrease) {
      counter--;
    } else if (event == CounterEvent.Reset) {
      counter = 0;
    }

    // Passing event to state stream
    _counterSink.add(counter);
  }

  void disposed() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
