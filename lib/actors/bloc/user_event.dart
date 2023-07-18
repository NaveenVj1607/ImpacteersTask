part of 'users_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUserListEvent extends UserEvent {
  final int page;

  const FetchUserListEvent({required this.page});

  @override
  List<Object> get props => [page];
}

class FetchUserDetailEvent extends UserEvent {
  final int id;

  const FetchUserDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}
