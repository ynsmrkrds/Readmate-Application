import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readmate_app/models/reader_user.dart';
import 'package:readmate_app/services/authentication_service.dart';

class ProfileViewModel {
  void signOut(BuildContext context) async {
    if (await AuthenticationService.signOut() == true) {
      Navigator.pushReplacementNamed(context, "/authentication");
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text("Oturum kapatılma işlemi gerçekleştirilemedi!"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  ReaderUser get readerUser {
    User? user = AuthenticationService.getUser();

    if (user == null) {
      return ReaderUser(name: "-----", email: "-----", photoUrl: "-----");
    }

    return ReaderUser(
      name: user.displayName ?? "-----",
      email: user.email ?? "-----",
      photoUrl: user.photoURL ?? "-----",
    );
  }
}
