class AppUser {
  final String uid;
  final String email;
  final String name;

  AppUser({required this.uid, required this.email, required this.name});

  /// Convert AppUser to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  /// Convert JSON to AppUser

  factory AppUser.fromJSON(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      email: jsonUser['email'],
      name: jsonUser['name'],
    );
  }
}
