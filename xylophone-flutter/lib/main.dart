import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  void playMusic(int no) {
    final player = AudioCache();
    player.play('note$no.wav');
  }

  Expanded buildKey({int no, Color color}) => Expanded(
        child: FlatButton(
          onPressed: () {
            playMusic(no);
          },
          color: color,
          child: null,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKey(no: 1, color: Colors.red),
              buildKey(no: 2, color: Colors.green),
              buildKey(no: 3, color: Colors.yellow),
              buildKey(no: 4, color: Colors.teal),
              buildKey(no: 5, color: Colors.orange),
              buildKey(no: 6, color: Colors.blue),
              buildKey(no: 7, color: Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}
