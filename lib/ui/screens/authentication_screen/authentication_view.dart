import 'package:flutter/material.dart';
import 'package:readmate_app/ui/screens/authentication_screen/authentication_viewmodel.dart';
import 'package:readmate_app/ui/widgets/logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      children: [
        LogoWidget(),
        Column(
          children: [
            buildContinueWithGoogleButton(context),
            SizedBox(height: 24.0.h),
            buildContinueAsGuest(context),
          ],
        ),
      ],
    );
  }

  TextButton buildContinueWithGoogleButton(BuildContext context) {
    return TextButton.icon(
      icon: googleIcon,
      label: getLabel("Continue with Google"),
      style: buttonStyle,
      onPressed: () => _viewModel.continueWithGoogle(context),
    );
  }

  Image get googleIcon => Image.asset(
        "assets/google_logo.png",
        height: 25.h,
      );

  TextButton buildContinueAsGuest(BuildContext context) {
    return TextButton.icon(
      icon: accountIcon,
      label: getLabel("Continue as a Guest"),
      style: buttonStyle,
      onPressed: () => _viewModel.goToHomeView(context),
    );
  }

  Icon get accountIcon => Icon(
        Icons.account_circle,
        size: 30.0.h,
      );

  Text getLabel(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black54,
        fontSize: 16.0.sp,
      ),
    );
  }

  ButtonStyle get buttonStyle => ButtonStyle(
        elevation: MaterialStateProperty.all<double>(5.0.w),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      );
}
