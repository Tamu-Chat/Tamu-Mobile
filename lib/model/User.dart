class UserProfile {
  final String username;
  final String phonenumber;
  final String uid;
  final String profilePicture;
  final String about;

  UserProfile(
      {this.username,
      this.phonenumber,
      this.uid,
      this.profilePicture,
      this.about});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'],
      phonenumber: json['phonenumber'],
      uid: json['uid'],
      profilePicture: json['profile_picture'],
      about: json['about'],
    );
  }
}
