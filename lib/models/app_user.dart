class AppUser {
  final String uid;
  final String name;
  final String email;
  final String? phone;
  AppUser({required this.uid, required this.name, required this.email, this.phone});

  Map<String, dynamic> toMap() =>
      {'uid': uid, 'name': name, 'email': email, 'phone': phone};

  factory AppUser.fromMap(Map<String, dynamic> m) => AppUser(
        uid: m['uid'] ?? '',
        name: m['name'] ?? '',
        email: m['email'] ?? '',
        phone: m['phone'],
      );
}
