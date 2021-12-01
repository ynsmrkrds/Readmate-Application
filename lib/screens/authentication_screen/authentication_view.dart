import 'package:flutter/material.dart';
import 'package:readmate_app/screens/authentication_screen/authentication_viewmodel.dart';

class AuthenticationView extends StatelessWidget {
  final AuthenticationViewModel _viewModel = AuthenticationViewModel();

  AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildBody(context),
      ),
    );
  }

  Column buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildContinueWithGoogleButton(context),
        buildContinueAsGuest(context),
      ],
    );
  }

  TextButton buildContinueWithGoogleButton(BuildContext context) {
    return TextButton.icon(
      icon: Image.asset(
        "assets/google_logo.png",
        height: 25,
      ),
      label: const Text(
        "Google ile Devam Et",
        style: TextStyle(color: Colors.black54),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(5.0),
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
      ),
      onPressed: () {
        _viewModel.continueWithGoogle(context);
      },
    );
  }

  TextButton buildContinueAsGuest(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(
        Icons.account_circle,
        size: 30,
      ),
      label: const Text(
        "Misafir Olarak Devam Et",
        style: TextStyle(color: Colors.black54),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(5.0),
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
      ),
      onPressed: () {},
    );
  }
}
