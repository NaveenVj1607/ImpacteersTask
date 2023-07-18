import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_actors_app/actors/models/user_list_response.dart';
import 'package:movie_actors_app/actors/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UsersBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UsersBloc(this.userRepository) : super(UserInitial());

  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchUserListEvent) {
      yield UserListLoadingState();

      try {
        final userListResponse = await userRepository.getUserList(event.page);
        yield UserListLoadSuccessState(userListResponse: userListResponse);
      } catch (e) {
        yield UserListLoadFailureState();
      }
    } else if (event is FetchUserDetailEvent) {
      yield UserListLoadingState();

      try {
        final user = await userRepository.getUser(event.id);
        yield UserDetailLoadSuccessState(user: user);
      } catch (e) {
        yield UserDetailLoadFailureState();
      }
    }
  }
}
