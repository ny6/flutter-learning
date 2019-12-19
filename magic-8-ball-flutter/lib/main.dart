import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ask me Anything'),
          backgroundColor: Colors.blue.shade900,
        ),
        body: Magic8Ball(),
      ),
    ),
  );
}

class Magic8Ball extends StatefulWidget {
  @override
  _Magic8BallState createState() => _Magic8BallState();
}

class _Magic8BallState extends State<Magic8Ball> {
  int imageNumber = 1;

  void onButtonPress() {
    setState(() {
      imageNumber = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: FlatButton(
          onPressed: onButtonPress,
          child: Image(
            image: AssetImage('images/ball$imageNumber.png'),
          ),
        ),
      ),
    );
  }
}
