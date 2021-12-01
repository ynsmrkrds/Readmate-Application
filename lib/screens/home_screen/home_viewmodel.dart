import 'package:flutter/material.dart';

class HomeViewModel {
  void goToProfileView(BuildContext context) {
    Navigator.pushNamed(context, "/profile");
  }
}
