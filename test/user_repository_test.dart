import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'dart:convert';
import 'package:movie_actors_app/actors/models/user_list_response.dart';
import 'package:movie_actors_app/actors/repository/user_repository.dart';

var sampleResponse = {
  "page": 2,
  "per_page": 6,
  "total": 12,
  "total_pages": 2,
  "data": [
    {
      "id": 7,
      "email": "michael.lawson@reqres.in",
      "first_name": "Michael",
      "last_name": "Lawson",
      "avatar": "https://reqres.in/img/faces/7-image.jpg"
    },
    {
      "id": 8,
      "email": "lindsay.ferguson@reqres.in",
      "first_name": "Lindsay",
      "last_name": "Ferguson",
      "avatar": "https://reqres.in/img/faces/8-image.jpg"
    },
    {
      "id": 9,
      "email": "tobias.funke@reqres.in",
      "first_name": "Tobias",
      "last_name": "Funke",
      "avatar": "https://reqres.in/img/faces/9-image.jpg"
    },
    {
      "id": 10,
      "email": "byron.fields@reqres.in",
      "first_name": "Byron",
      "last_name": "Fields",
      "avatar": "https://reqres.in/img/faces/10-image.jpg"
    },
    {
      "id": 11,
      "email": "george.edwards@reqres.in",
      "first_name": "George",
      "last_name": "Edwards",
      "avatar": "https://reqres.in/img/faces/11-image.jpg"
    },
    {
      "id": 12,
      "email": "rachel.howell@reqres.in",
      "first_name": "Rachel",
      "last_name": "Howell",
      "avatar": "https://reqres.in/img/faces/12-image.jpg"
    }
  ],
  "support": {
    "url": "https://reqres.in/#support-heading",
    "text":
        "To keep ReqRes free, contributions towards server costs are appreciated!"
  }
};

var initialPageUri = Uri.parse('https://reqres.in/api/users?page=1');

// Mocking the http.Client class
class MockHttpClient extends Mock implements http.Client {}

// Mocking the Connectivity class
class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late UserRepository userRepository;
  late MockHttpClient mockHttpClient;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockConnectivity = MockConnectivity();
    userRepository = UserRepository(
      httpClient: mockHttpClient,
      connectivity: mockConnectivity,
    );
  });

  group('getUserList', () {
    test('returns UserListResponse when API call is successful', () async {
      // Mocking the connectivity result
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.wifi);

      // Mocking the HTTP client response
      when(() => mockHttpClient.get(initialPageUri))
          .thenAnswer((_) async => http.Response(
                json.encode(sampleResponse), // Mock response data
                200, // Mock response status code
              ));

      final userListResponse = await userRepository.getUserList(1);

      expect(userListResponse, isA<UserListResponse>());
      // Add more assertions based on the expected behavior of UserListResponse
    });

    test('throws an exception when there is no internet connection', () async {
      // Mocking the connectivity result
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.none);

      expect(
          () => userRepository.getUserList(1),
          throwsA(isA<Exception>().having(
              (e) => e.toString(),
              'exception message',
              'Exception: No internet connection,please try again later.')));
    });

    test('throws an exception when the API call fails', () async {
      // Mocking the connectivity result
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.wifi);

      // Mocking the HTTP client response
      when(() => mockHttpClient.get(initialPageUri))
          .thenAnswer((_) async => http.Response('Error', 500));

      expect(
          () => userRepository.getUserList(1),
          throwsA(isA<Exception>().having((e) => e.toString(),
              'exception message', 'Exception: Failed to load users')));
    });
  });
}
