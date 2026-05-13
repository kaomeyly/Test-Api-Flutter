import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String email;
  String name;
  String avatar;
  UserModel({required this.email, required this.name, required this.avatar});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'name': name, 'avatar': avatar};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
