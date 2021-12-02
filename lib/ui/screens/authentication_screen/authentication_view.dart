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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildLogo(),
        Column(
          children: [
            buildContinueWithGoogleButton(context),
            const SizedBox(height: 24.0),
            buildContinueAsGuest(context),
          ],
        ),
      ],
    );
  }

  Image buildLogo() {
    return Image.asset(
      "assets/google_logo.png",
      height: 150,
    );
  }

  TextButton buildContinueWithGoogleButton(BuildContext context) {
    return TextButton.icon(
      icon: Image.asset(
        "assets/google_logo.png",
        height: 25,
      ),
      label: const Text(
        "Continue with Google",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
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
        "Continue as a Guest",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
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
