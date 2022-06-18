import 'package:firebase_core/firebase_core.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/init/provider_list.dart';
import 'package:smart_admin_dashboard/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
    apiKey: "AIzaSyD3Ky1EDtYCcOFANY2p9fZJ3hlFF2MHScc",
    authDomain: "proyectoemprendedores-7faf9.firebaseapp.com",
    projectId: "proyectoemprendedores-7faf9",
    storageBucket: "proyectoemprendedores-7faf9.appspot.com",
    messagingSenderId: "591948681984",
    appId: "1:591948681984:web:a7e6234af80952ac9659e5"
    ),
  );
  runApp(MyApp());
}

Widget build(BuildContext context) {
  return MultiProvider(

      providers: [...ApplicationProvider.instance.dependItems,
       ],

      child: FutureBuilder(
        builder: (context, snapshot) {
          return MyApp();
        },
      )
      
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Dashboard - Admin Panel v0.1 ',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: bgColor, elevation: 0),
        scaffoldBackgroundColor: bgColor,
        primaryColor: greenColor,
        dialogBackgroundColor: secondaryColor,
        buttonColor: greenColor,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: Login(title: "Wellcome to the Admin & Dashboard Panel"),
    );
  }
}
