import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/counter_bloc.dart';
import 'package:flutter_bloc_pattern/news_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const NewsPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterBloc = CounterBloc();

  @override
  void dispose() {
    counterBloc.disposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<Object>(
              stream: counterBloc.counterStream,
              initialData: 0,
              builder: (context, snapshot) {
                // if (snapshot.hasData) {
                //   return Text(
                //     '${snapshot.data}',
                //     style: Theme.of(context).textTheme.headline4,
                //   );
                // }
                // if (snapshot.hasError) {
                //   print(snapshot.error);
                // }
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventSink.add(CounterEvent.Increase);
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventSink.add(CounterEvent.Decrease);
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventSink.add(CounterEvent.Reset);
            },
            tooltip: 'Reset',
            child: const Icon(Icons.restore),
          ),
        ],
      ),
    );
  }
}
