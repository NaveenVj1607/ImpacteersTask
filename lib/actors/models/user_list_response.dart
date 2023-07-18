class UserListResponse {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<User> users;
  Support support;

  UserListResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.users,
    required this.support,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) {
    return UserListResponse(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      users: (json['data'] as List<dynamic>)
          .map((userData) => User.fromJson(userData))
          .toList(),
      support: Support.fromJson(json['support']),
    );
  }
}

class User {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}

class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      url: json['url'],
      text: json['text'],
    );
  }
}
