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
    _subscription = NotificationCenter().subscribe<void>(
      'incrementW1Counter',
      (_) => _incrementCounter(),
      // ignore: avoid_print
      onPause: () => print('Widget 1 paused'),
      // ignore: avoid_print
      onResume: () => print('Widget 1 resumed'),
      // ignore: avoid_print
      onCancel: () => print('Widget 1 cancelled'),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blue.shade50,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Widget 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Counter: $_counter', style: const TextStyle(fontSize: 18)),
            Text('Status: ${_enabled ? "Active" : "Paused"}', style: TextStyle(color: _enabled ? Colors.green : Colors.red)),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                NotificationCenter().notify<int>('incrementW2Counter', data: 5);
              },
              child: const Text('Increment Widget 2 by 5'),
            ),
            SwitchListTile(
              title: const Text('Receive Notifications'),
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
              },
            ),
          ],
        ),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}
