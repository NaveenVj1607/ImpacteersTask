import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_actors_app/actors/models/user_list_response.dart';
import 'package:movie_actors_app/actors/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UsersBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UsersBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUserListEvent>(_fetchUserList);
    on<FetchUserDetailEvent>(_fetchUserDetail);
  }

  Future<void> _fetchUserList(
      FetchUserListEvent event, Emitter<UserState> emit) async {
    emit(UserListLoadingState());

    try {
      final userListResponse = await userRepository.getUserList(event.page);
      emit(UserListLoadSuccessState(userListResponse: userListResponse));
    } catch (e) {
      emit(UserListLoadFailureState());
    }
  }

  Future<void> _fetchUserDetail(
      FetchUserDetailEvent event, Emitter<UserState> emit) async {
    emit(UserListLoadingState());

    try {
      final user = await userRepository.getUser(event.id);
      emit(UserDetailLoadSuccessState(user: user));
    } catch (e) {
      emit(UserDetailLoadFailureState());
    }
  }
}
