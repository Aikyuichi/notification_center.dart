import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';

class Widget2 extends StatefulWidget {
  const Widget2({Key? key}) : super(key: key);

  @override
  _Widget2State createState() => _Widget2State();

}

class _Widget2State extends State<Widget2> with WidgetsBindingObserver {

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    NotificationCenter().subscribe('incrementW2Counter', (int data) {
      setState(() {
        _counter += data;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
      ],
    );
  }
}