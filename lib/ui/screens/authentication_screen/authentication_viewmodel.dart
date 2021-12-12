import 'package:flutter/material.dart';
import 'package:readmate_app/core/providers/account_provider.dart';

class AuthenticationViewModel {
  void continueWithGoogle(BuildContext context) async {
    if (await accountProvider.signIn() == true) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text("Authentication failed!"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
