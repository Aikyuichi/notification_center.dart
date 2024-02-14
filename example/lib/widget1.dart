import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';

class Widget1 extends StatefulWidget {
  const Widget1({Key? key}) : super(key: key);

  @override
  State<Widget1> createState() => _Widget1State();

}

class _Widget1State extends State<Widget1> {

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    NotificationCenter().subscribe('incrementW1Counter', _incrementCounter);
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('incrementW1Counter');
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