import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_admin_dashboard/entities/user_model.dart';

class UserService {
  Future<List<UserModel>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  static Future<UserModel> userGetById(String id) async {
    final snap =
        await FirebaseFirestore.instance.collection("users").doc(id).get();

    if (snap.exists) {
      return UserModel.fromDocumentSnapshot(snap);
    } else {
      return userEmpty();
    }
  }

  Future<UserModel> getByEmailAndPassword(String email, String password) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get();
    String idDoc = querySnapshot.docs.first.id;
    var data = querySnapshot.docs.first.data();
    if (idDoc.isEmpty) {
      return userEmpty();
    } else {
      return userEmpty();
    }
  }
}
