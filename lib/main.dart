import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmate_app/screens/details_screen/details_view.dart';
import 'package:readmate_app/ui/screens/authentication_screen/authentication_view.dart';
import 'package:readmate_app/ui/screens/home_screen/home_view.dart';
import 'package:readmate_app/ui/screens/home_screen/home_viewmodel.dart';
import 'package:readmate_app/ui/screens/profile_screen/profile_view.dart';
import 'package:readmate_app/ui/screens/splash_screen/splash_view.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ReadmateApp());
}

class ReadmateApp extends StatelessWidget {
  const ReadmateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(create: (context) => HomeViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const SplashView(),
          "/authentication": (context) => AuthenticationView(),
          "/home": (context) => const HomeView(),
          "/profile": (context) => ProfileView(),
          "/details": (context) => const DetailsView(),
        },
        initialRoute: "/",
      ),
    );
  }
}
