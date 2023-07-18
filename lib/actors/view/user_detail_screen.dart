import 'package:flutter/material.dart';
import 'package:movie_actors_app/actors/models/user_list_response.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.firstName} ${user.lastName}"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: Hero(
                tag: "avatar_${user.id.toString()}",
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(user.avatar),
                ),
              ),
            ),
            Text(
              "${user.firstName} ${user.lastName}",
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
