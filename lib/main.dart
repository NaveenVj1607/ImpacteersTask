import 'package:flutter/material.dart';
import 'package:movie_actors_app/actors/view/user_list_screen.dart';

void main() {
  runApp(const MovieActorsApp());
}

class MovieActorsApp extends StatelessWidget {
  const MovieActorsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Actors',
      theme: ThemeData(fontFamily: 'SF-Pro'),
      home: const UserListScreen(),
    );
  }
}
