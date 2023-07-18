import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_actors_app/actors/models/user_list_response.dart';

class UserRepository {
  Future<UserListResponse> getUserList(int page) async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return UserListResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUser(int userId) async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users/$userId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return User.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
