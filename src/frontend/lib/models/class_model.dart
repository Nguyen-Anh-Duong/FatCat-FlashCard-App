class ClassModel {
  final int id;
  final String name;
  final String description;
  final String createdBy;
  final String codeInvite;

  ClassModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdBy,
    required this.codeInvite,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    final ClassModel classModel = ClassModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdBy: json['created_by'] ?? '',
      codeInvite: json['code_invite'] ?? '',
    );

    return classModel;
  }
}
