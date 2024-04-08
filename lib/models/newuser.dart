class NewUser {
  NewUser({
    required this.name,
    required this.createdAt,
    required this.id,
    required this.email,
  });
  late  String name;
  late  String createdAt;
  late  String id;
  late  String email;

  NewUser.fromJson(Map<String, dynamic> json){
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['email'] = email;
    return data;
  }
}