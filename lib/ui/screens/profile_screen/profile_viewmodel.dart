import 'package:flutter/material.dart';
import 'package:readmate_app/core/models/user.dart';
import 'package:readmate_app/core/providers/account_provider.dart';

class ProfileViewModel {
  void signOut(BuildContext context) async {
    if (await accountProvider.signOut() == true) {
      Navigator.pushReplacementNamed(context, "/authentication");
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text("Failed to Sign Out"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  User get user {
    if (accountProvider.user == null) {
      return User(
        name: "Guest",
        email: "There is no email address.",
        photoUrl: "https://cdn.pixabay.com/photo/2018/09/06/18/26/person-3658927_960_720.png",
        uid: "0",
      );
    } else {
      return accountProvider.user!;
    }
  }
}
