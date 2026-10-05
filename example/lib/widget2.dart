import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';

class Widget2 extends StatefulWidget {
  const Widget2({super.key});

  @override
  State<Widget2> createState() => _Widget2State();
}

class _Widget2State extends State<Widget2> {
  late final NotificationSubscription _subscription;
  bool _enabled = true;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _subscription = NotificationCenter().subscribe<int>(
      'incrementW2Counter',
      (int data) {
        setState(() {
          _counter += data;
        });
      },
      // ignore: avoid_print
      onPause: () => print('Widget 2 paused'),
      // ignore: avoid_print
      onResume: () => print('Widget 2 resumed'),
      // ignore: avoid_print
      onCancel: () => print('Widget 2 cancelled'),
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
      color: Colors.green.shade50,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Widget 2', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Counter: $_counter', style: const TextStyle(fontSize: 18)),
            Text('Status: ${_enabled ? "Active" : "Paused"}', style: TextStyle(color: _enabled ? Colors.green : Colors.red)),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                NotificationCenter().notify('incrementW1Counter');
              },
              child: const Text('Increment Widget 1'),
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
}
