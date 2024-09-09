class User {
  final String uid;
  final String name;
  final String logoUrl;

  User({
    required this.uid,
    required this.name,
    required this.logoUrl,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      logoUrl: map['logoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return toMap();
  }
}
