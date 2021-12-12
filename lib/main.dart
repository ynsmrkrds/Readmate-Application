import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmate_app/core/providers/account_provider.dart';
import 'package:readmate_app/core/providers/bookshelf_provider.dart';
import 'package:readmate_app/core/providers/ebook_provider.dart';
import 'package:readmate_app/core/providers/library_provider.dart';
import 'package:readmate_app/ui/screens/bookshelf_screen/bookshelf_view.dart';
import 'package:readmate_app/ui/screens/details_screen/details_view.dart';
import 'package:readmate_app/ui/screens/authentication_screen/authentication_view.dart';
import 'package:readmate_app/ui/screens/home_screen/home_view.dart';
import 'package:readmate_app/ui/screens/profile_screen/profile_view.dart';
import 'package:readmate_app/ui/screens/reading_screen/reading_view.dart';
import 'package:readmate_app/ui/screens/searching_screen/searching_view.dart';
import 'package:readmate_app/ui/screens/splash_screen/splash_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
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
        ChangeNotifierProvider<LibraryProvider>(create: (context) => libraryProvider),
        ChangeNotifierProvider<BookshelfProvider>(create: (context) => bookshelfProvider),
        ChangeNotifierProvider<AccountProvider>(create: (context) => accountProvider),
        ChangeNotifierProvider<EbookProvider>(create: (context) => ebookProvider),
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 640),
        builder: () {
          return MaterialApp(
            title: "Readmate",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xffe8e8e8),
              appBarTheme: AppBarTheme(
                backgroundColor: Color(0xff7b7575),
              ),
            ),
            routes: {
              "/": (context) => SplashView(),
              "/authentication": (context) => AuthenticationView(),
              "/home": (context) => const HomeView(),
              "/profile": (context) => ProfileView(),
              "/details": (context) => DetailsView(),
              "/searching": (context) => const SearchingView(),
              "/bookshelf": (context) => const BookshelfView(),
              "/reading": (context) => ReadingView(),
            },
            initialRoute: "/",
          );
        },
      ),
    );
  }
}
