class UserModel {
  final String id;
  final String name;
  final String? email;
  final String? role;
  final String? joinedAt;

  UserModel(
      {required this.id,
      required this.name,
      this.email,
      this.role,
      this.joinedAt});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    UserModel user = UserModel(
        id: json['userId'].toString(),
        name: json['userName'],
        email: json['email'],
        role: json['role'],
        joinedAt: json['joinedAt']);
    return user;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name role:$role joinedAt:$joinedAt}';
  }
}
