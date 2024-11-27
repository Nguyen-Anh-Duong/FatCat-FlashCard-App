class ClassModel {
  final String id;
  final String name;
  final String description;
  final String createdBy;
  final String codeInvite;
  final String? role;

  ClassModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdBy,
    required this.codeInvite,
    this.role,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    final ClassModel classModel = ClassModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdBy: json['created_by'] ?? '',
      codeInvite: json['code_invite'] ?? '',
      role: json['role'] ?? '',
    );
    return classModel;
  }
}
