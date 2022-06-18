import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String lastName;
  String email;
  String password;
  String role;

  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.data()!["id"].toString(),
        name = snapshot.data()!["name"].toString(),
        lastName = snapshot.data()!["lastName"].toString(),
        email = snapshot.data()!["email"].toString(),
        password = snapshot.data()!["password"].toString(),
        role = snapshot.data()!["role"].toString();
}

UserModel userEmpty({ String? id}) {
  return UserModel(
    id: "",
    name: "",
    lastName: "",
    email: "",
    password: "",
    role: "",
  );
}
