import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_univ_timer/next_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Timer App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _minute = 0;
  int _second = 0;
  int _millisecond = 0;
  Timer? _timer;
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '$_minute',
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                ),
                const Text(
                  ':',
                  style: TextStyle(fontSize: 60),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${_second % 60}',
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                ),
                const Text(
                  ':',
                  style: TextStyle(fontSize: 60),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${_millisecond % 100}',
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => toggleTimer(),
              child: Text(
                _isRunning ? 'ストップ' : 'スタート',
                style: TextStyle(
                  color: _isRunning ? Colors.red : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () => resetTimer(),
                child: const Text(
                  'リセット',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(
        const Duration(milliseconds: 10),
        (timer) {
          setState(() {
            _millisecond++;
            _second = (_millisecond / 100).floor();
            _minute = (_second / 60).floor();

            if (_minute == 3) {
              resetTimer();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const NextPage(); // 遷移先の画面widgetを指定
                  },
                ),
              );
            }
          });
        },
      );
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _minute = 0;
      _second = 0;
      _millisecond = 0;
      _isRunning = false;
    });
  }
}
