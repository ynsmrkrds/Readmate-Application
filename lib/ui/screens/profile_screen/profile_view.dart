import 'package:flutter/material.dart';
import 'package:readmate_app/ui/screens/profile_screen/profile_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  final ProfileViewModel _viewModel = ProfileViewModel();

  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: buildBody(context),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Profile"),
    );
  }

  Padding buildBody(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 48.0.h, horizontal: 24.0.w),
      child: Column(
        children: [
          buildUserDetailField(),
          SizedBox(height: 48.0.h),
          buildSignOutButton(context),
        ],
      ),
    );
  }

  Row buildUserDetailField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildUserProfileImage(),
        buildUserInformationField(),
      ],
    );
  }

  CircleAvatar buildUserProfileImage() {
    return CircleAvatar(
      radius: 45.0.r,
      backgroundImage: NetworkImage(_viewModel.user.photoUrl),
      backgroundColor: Colors.blue,
    );
  }

  Column buildUserInformationField() {
    return Column(
      children: [
        buildNameText(),
        SizedBox(height: 12.0.h),
        buildEmailText(),
      ],
    );
  }

  Text buildNameText() {
    return Text(
      _viewModel.user.name,
      style: TextStyle(fontSize: 28.0.sp),
    );
  }

  Text buildEmailText() {
    return Text(
      _viewModel.user.email,
      style: TextStyle(fontSize: 14.0.sp),
    );
  }

  TextButton buildSignOutButton(context) {
    return TextButton.icon(
      icon: Icon(
        Icons.logout,
        size: 36.h,
        color: Color(0xffff5757),
      ),
      label: label,
      style: buttonStyle,
      onPressed: () => _viewModel.signOut(context),
    );
  }

  Text get label => Text(
        "Sign Out",
        style: TextStyle(color: Colors.black54, fontSize: 18.0.sp),
      );

  ButtonStyle get buttonStyle => ButtonStyle(
        elevation: MaterialStateProperty.all<double>(5.0.w),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      );
}
