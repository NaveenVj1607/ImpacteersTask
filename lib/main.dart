import 'package:flutter/material.dart';

void main() {
  runApp(const MovieActorsApp());
}

class MovieActorsApp extends StatelessWidget {
  const MovieActorsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Actors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
