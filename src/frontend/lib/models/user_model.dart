class UserModel {
  final String id;
  final String name;

  UserModel({
    required this.id,
    required this.name,
  });

  Map <String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
  @override
  String toString() {
    return 'User{id: $id, name: $name}';
  }
}