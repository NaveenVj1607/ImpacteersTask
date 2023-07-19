import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_actors_app/actors/models/user_list_response.dart';

class UserRepository {
  final http.Client httpClient;
  final Connectivity connectivity;

  UserRepository({
    http.Client? httpClient,
    Connectivity? connectivity,
  })  : httpClient = httpClient ?? http.Client(),
        connectivity = connectivity ?? Connectivity();

  Future<UserListResponse> getUserList(int page) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      throw Exception("No internet connection,please try again later.");
    }
    final response = await httpClient
        .get(Uri.parse('https://reqres.in/api/users?page=$page'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return UserListResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load users');
    }
  }

// NOTE: Mostly this is not used since we are getting the same details from the list
  Future<User> getUser(int userId) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      throw Exception("No internet connection,please try again later.");
    }
    final response =
        await httpClient.get(Uri.parse('https://reqres.in/api/users/$userId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return User.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
