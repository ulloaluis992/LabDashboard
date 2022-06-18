import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/entities/user_model.dart';
import 'package:smart_admin_dashboard/screens/home/home_screen.dart';
import 'package:smart_admin_dashboard/services/firebase_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel userModel = userEmpty();
  final auth = FirebaseAuth.instance;

  Future<void> LogIn(BuildContext context) async {
    if (userModel.email.trim() != "" && userModel.password.trim() != "") {
      try {
        await auth.signInWithEmailAndPassword(
          email: userModel.email,
          password: userModel.password,
        );
        if (auth.currentUser != null) {
          userModel.id = auth.currentUser!.uid;
          userModel = await UserService.userGetById(userModel.id);
          print("email: " +
              userModel.email.toString() +
              ", id:" +
              userModel.id.toString());

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } catch (ex) {
        print("Ha ocurrido un error al iniciar sesion");
      }
    } else {
     print("Ha ocurrido un error al iniciar sesion");
    }

    notifyListeners();
  }
}
