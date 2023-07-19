import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_actors_app/actors/models/user_list_response.dart';
import 'package:movie_actors_app/actors/view/user_detail_screen.dart';

class UserListTile extends StatelessWidget {
  final User user;
  const UserListTile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: Hero(
          tag: "avatar_${user.id.toString()}",
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              user.avatar,
            ),
          ),
        ),
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Text(user.email),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailScreen(
                user: user,
              ),
            ),
          );
        },
      ),
    );
  }
}
