import 'package:flutter/material.dart';
import 'package:movie_actors_app/actors/view/user_list_screen.dart';
import 'package:movie_actors_app/helpers.dart';

void main() {
  runApp(const MovieActorsApp());
}

class MovieActorsApp extends StatelessWidget {
  const MovieActorsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Actors',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF-Pro',
        primarySwatch: createMaterialColor(const Color(0xffec4400)),
        primaryColor: const Color(0xffec4400),
      ),
      home: const UserListScreen(),
    );
  }
}
