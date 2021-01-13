class User {
  final String username;
  final String phonenumber;

  User({this.username, this.phonenumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      phonenumber: json['phonenumber'],
    );
  }
}
