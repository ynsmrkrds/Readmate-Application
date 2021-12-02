import 'package:flutter/material.dart';
import 'package:readmate_app/ui/screens/splash_screen/splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = SplashViewModel();

    _viewModel.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/google_logo.png",
          height: 150,
        ),
      ),
    );
  }
}
