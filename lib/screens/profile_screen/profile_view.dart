import 'package:flutter/material.dart';
import 'package:readmate_app/screens/profile_screen/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  final ProfileViewModel _viewModel = ProfileViewModel();

  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: buildBody(context),
      ),
    );
  }

  buildBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 48.0,
            horizontal: 24.0,
          ),
          child: buildUserDetailField(),
        ),
        buildSignOutButton(context)
      ],
    );
  }

  Row buildUserDetailField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildUserAvatarImage(),
        buildUserInformationField(),
      ],
    );
  }

  CircleAvatar buildUserAvatarImage() {
    return CircleAvatar(
      radius: 45.0,
      backgroundImage: NetworkImage(
        _viewModel.readerUser.photoUrl,
      ),
      backgroundColor: Colors.blue,
    );
  }

  Column buildUserInformationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _viewModel.readerUser.name,
          style: const TextStyle(fontSize: 28.0),
        ),
        const SizedBox(height: 12.0),
        Text(
          _viewModel.readerUser.email,
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }

  TextButton buildSignOutButton(context) {
    return TextButton.icon(
      icon: const Icon(
        Icons.logout,
        size: 36,
      ),
      label: const Text(
        "Sign Out",
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
        _viewModel.signOut(context);
      },
    );
  }
}
