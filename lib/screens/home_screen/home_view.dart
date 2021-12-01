import 'package:flutter/material.dart';
import 'package:readmate_app/screens/home_screen/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel _viewModel = HomeViewModel();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("ReadMate"),
        actions: [
          buildSearchButton(),
          buildGoToBookshelfButton(),
          buildGoToProfileButton(context),
        ],
      ),
      body: Center(
        child: buildBody(),
      ),
    );
  }

  IconButton buildSearchButton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search),
    );
  }

  IconButton buildGoToBookshelfButton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.collections_bookmark_sharp),
    );
  }

  IconButton buildGoToProfileButton(context) {
    return IconButton(
      icon: const Icon(Icons.account_circle),
      onPressed: () {
        _viewModel.goToProfileView(context);
      },
    );
  }

  Text buildBody() {
    return const Text("Buraya gerekli eklemeler yapılacaktır.");
  }
}
