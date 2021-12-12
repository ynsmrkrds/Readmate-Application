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

  User get user => accountProvider.user!;
}
