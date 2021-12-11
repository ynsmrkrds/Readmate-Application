import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmate_app/providers/bookshelf_provider.dart';
import 'package:readmate_app/providers/ebook_provider.dart';
import 'package:readmate_app/providers/library_provider.dart';
import 'package:readmate_app/ui/screens/bookshelf_screen/bookshelf_view.dart';
import 'package:readmate_app/ui/screens/details_screen/details_view.dart';
import 'package:readmate_app/ui/screens/authentication_screen/authentication_view.dart';
import 'package:readmate_app/ui/screens/home_screen/home_view.dart';
import 'package:readmate_app/ui/screens/profile_screen/profile_view.dart';
import 'package:readmate_app/ui/screens/reading_screen/reading_view.dart';
import 'package:readmate_app/ui/screens/searching_screen/searching_view.dart';
import 'package:readmate_app/ui/screens/splash_screen/splash_view.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ReadMateApp());
}

class ReadMateApp extends StatelessWidget {
  const ReadMateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EbookProvider>(create: (context) => ebookProvider),
        ChangeNotifierProvider<LibraryProvider>(create: (context) => libraryProvider),
        ChangeNotifierProvider<BookshelfProvider>(create: (context) => bookshelfProvider),
      ],
      child: MaterialApp(
        title: "Readmate",
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const SplashView(),
          "/authentication": (context) => AuthenticationView(),
          "/home": (context) => const HomeView(),
          "/profile": (context) => ProfileView(),
          "/details": (context) => DetailsView(),
          "/searching": (context) => const SearchingView(),
          "/bookshelf": (context) => const BookshelfView(),
          "/reading": (context) => ReadingView(),
        },
        initialRoute: "/",
      ),
    );
  }
}
