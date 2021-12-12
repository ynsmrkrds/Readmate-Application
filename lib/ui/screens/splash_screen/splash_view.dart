import 'package:flutter/material.dart';
import 'package:readmate_app/ui/screens/splash_screen/splash_viewmodel.dart';
import 'package:readmate_app/ui/widgets/logo_widget.dart';

class SplashView extends StatelessWidget {
  final SplashViewModel _viewModel = SplashViewModel();

  SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _viewModel.checkAuthentication(context);

    return Scaffold(
      body: Center(
        child: LogoWidget(),
      ),
    );
  }
}
