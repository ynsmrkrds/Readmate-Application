import 'package:flutter/material.dart';
import 'package:readmate_app/services/authentication_service.dart';

class AuthenticationViewModel {
  void continueWithGoogle(BuildContext context) async {
    if (await AuthenticationService.signInWithGoogle() == true) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text("Doğrulama işlemi gerçekleştirilemedi!"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
