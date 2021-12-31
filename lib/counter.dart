import 'package:flutter/material.dart';

class Counter extends StatefulWidget {

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  late int value;

  @override
  void initState() {
    super.initState();
    value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              value--;
            });
          },
        ),
        Text(
            value.toString()
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              value++;
            });
          },
        ),
      ],
    );
  }
}