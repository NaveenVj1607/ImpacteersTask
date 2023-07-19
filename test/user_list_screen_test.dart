import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_actors_app/actors/bloc/users_bloc.dart';
import 'package:movie_actors_app/actors/models/user_list_response.dart';
import 'package:movie_actors_app/actors/view/user_list_screen.dart';
import 'package:movie_actors_app/actors/view/user_list_tile.dart';
import 'package:bloc_test/bloc_test.dart';

import 'user_repository_test.dart';

class MockUsersBloc extends MockBloc<UserEvent, UserState>
    implements UsersBloc {}

void main() {
  late MockUsersBloc mockUsersBloc;

  setUp(() {
    mockUsersBloc = MockUsersBloc();
  });

  testWidgets('UserListScreen - Loading State', (WidgetTester tester) async {
    when(() => mockUsersBloc.state).thenReturn(UserListLoadingState());

    await tester.pumpWidget(
      MaterialApp(
        home: UserListScreen(usersBloc: mockUsersBloc),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('UserListScreen - Load Success State',
      (WidgetTester tester) async {
    var userListResponse = UserListResponse.fromJson(sampleResponse);
    when(() => mockUsersBloc.state).thenReturn(
        UserListLoadSuccessState(userListResponse: userListResponse));

    await tester.pumpWidget(
      MaterialApp(
        home: UserListScreen(usersBloc: mockUsersBloc),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(UserListTile), findsNWidgets(6));
  });

  testWidgets('UserListScreen - Load Failure State',
      (WidgetTester tester) async {
    when(() => mockUsersBloc.state).thenReturn(UserListLoadFailureState());

    await tester.pumpWidget(
      MaterialApp(
        home: UserListScreen(usersBloc: mockUsersBloc),
      ),
    );

    expect(find.text('Failed to load user list'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
