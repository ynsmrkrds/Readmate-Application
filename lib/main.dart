import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:readmate_app/screens/authentication_screen/authentication_view.dart';
import 'package:readmate_app/screens/home_screen/home_view.dart';
import 'package:readmate_app/screens/profile_screen/profile_view.dart';
import 'package:readmate_app/screens/splash_screen/splash_view.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ReadmateApp());
}

class ReadmateApp extends StatelessWidget {
  const ReadmateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const SplashView(),
        "/authentication": (context) => AuthenticationView(),
        "/home": (context) => HomeView(),
        "/profile": (context) => ProfileView(),
      },
      initialRoute: "/",
    );
  }
}