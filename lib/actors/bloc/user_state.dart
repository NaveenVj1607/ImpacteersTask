part of 'users_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserListLoadSuccessState extends UserState {
  final UserListResponse userListResponse;

  const UserListLoadSuccessState({required this.userListResponse});

  @override
  List<Object> get props => [userListResponse];
}

class UserListLoadFailureState extends UserState {
  @override
  List<Object> get props => [];
}

class UserListLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserDetailLoadSuccessState extends UserState {
  final User user;

  const UserDetailLoadSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class UserDetailLoadFailureState extends UserState {
  @override
  List<Object> get props => [];
}
