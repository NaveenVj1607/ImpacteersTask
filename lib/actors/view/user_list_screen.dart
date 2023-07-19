import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_actors_app/actors/bloc/users_bloc.dart';
import 'package:movie_actors_app/actors/models/user_list_response.dart';
import 'package:movie_actors_app/actors/repository/user_repository.dart';
import 'package:movie_actors_app/actors/view/user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  final UsersBloc? usersBloc;
  const UserListScreen({super.key, this.usersBloc});
  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  late UsersBloc _usersBloc;
  UserListResponse? latestUserResponse;
  List<User> users = [];
  int latestPage = 1;

  @override
  void initState() {
    super.initState();
    _usersBloc = widget.usersBloc ?? UsersBloc(UserRepository());
    _usersBloc.add(const FetchUserListEvent(page: 1));
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _usersBloc.close();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadUsers();
    }
  }

  void _loadUsers() {
    if (latestUserResponse != null &&
        latestUserResponse!.totalPages >= latestPage) {
      _usersBloc.add(FetchUserListEvent(page: latestPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: BlocBuilder<UsersBloc, UserState>(
        bloc: _usersBloc,
        builder: (context, state) {
          if (state is UserListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserListLoadSuccessState) {
            if (latestPage == state.userListResponse.page) {
              latestPage++;
              latestUserResponse = state.userListResponse;
              users.addAll(state.userListResponse.users);
            }

            return ListView.builder(
              controller: _scrollController,
              itemCount: latestPage > state.userListResponse.totalPages
                  ? users.length
                  : users.length + 1,
              itemBuilder: (context, index) {
                if (index == users.length) {
                  if (state.userListResponse.page > 1) {
                    return const ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          _loadUsers();
                        },
                        child: const Text("Load more"),
                      ),
                    );
                  }
                } else {
                  final user = users[index];
                  return UserListTile(user: user);
                }
              },
            );
          } else if (state is UserListLoadFailureState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Failed to load user list"),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      users = [];
                      _usersBloc.add(const FetchUserListEvent(page: 1));
                    },
                    child: const Text("Retry"),
                  ),
                )
              ],
            ));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

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
