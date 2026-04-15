import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';

class Widget1 extends StatefulWidget {
  const Widget1({super.key});

  @override
  State<Widget1> createState() => _Widget1State();
}

class _Widget1State extends State<Widget1> {
  late final NotificationSubscription _subscription;
  bool _enabled = true;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _subscription = NotificationCenter().subscribe(
      'incrementW1Counter',
      _incrementCounter,
      onPause: () => print('incrementCounter of widget1 paused'),
      onResume: () => print('incrementCounter of widget1 resumed'),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.maxFinite,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Text('Widget1', style: TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text('Counter: $_counter', style: const TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                NotificationCenter().notify<int>('incrementW2Counter', data: 5);
              },
              child: const Text('Increment Widget2 counter'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Switch(
                value: _enabled,
                onChanged: (bool value) {
                  if (value) {
                    _subscription.resume();
                  } else {
                    _subscription.pause();
                  }
                  setState(() {
                    _enabled = value;
                  });
                }
            ),
          ),
        ],
      ),
    );
  }

  void _incrementCounter(data) {
    setState(() {
      _counter++;
    });
  }
}