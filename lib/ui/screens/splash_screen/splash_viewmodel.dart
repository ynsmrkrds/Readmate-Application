import 'dart:async';

import 'package:flutter/material.dart';
import 'package:readmate_app/services/authentication_service.dart';

class SplashViewModel {
  void checkAuthentication(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      if (AuthenticationService.getUser() == null) {
        _goToAuthenticationView(context);
      } else {
        _goToHomeView(context);
      }
    });
  }

  void _goToAuthenticationView(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/authentication");
  }

  void _goToHomeView(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }
}
