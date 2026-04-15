import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';

class Widget2 extends StatefulWidget {
  const Widget2({super.key});

  @override
  State<Widget2> createState() => _Widget2State();
}

class _Widget2State extends State<Widget2> with WidgetsBindingObserver {
  late final NotificationSubscription _subscription;
  bool _enabled = true;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
     _subscription = NotificationCenter().subscribe(
       'incrementW2Counter',
         (int data) {
         setState(() {
           _counter += data;
         });
         },
       onPause: () => print('incrementCounter of widget2 paused'),
       onResume: () => print('incrementCounter of widget1 resumed'),
     );
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('incrementW2Counter');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Text('Widget2'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Text('Counter: $_counter'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {
              NotificationCenter().notify('incrementW1Counter');
            },
            child: const Text('Increment Widget1 counter'),
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
    );
  }
}