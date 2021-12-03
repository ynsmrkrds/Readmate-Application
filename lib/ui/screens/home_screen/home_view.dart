import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmate_app/enums/menu_items.dart';
import 'package:readmate_app/providers/ebook_provider.dart';
import 'package:readmate_app/ui/screens/home_screen/home_viewmodel.dart';
import 'package:readmate_app/ui/widgets/ebooks_frame_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    // initializes the view model
    _viewModel = HomeViewModel();

    // starts the fetching ebooks process
    _viewModel.fetchEbooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: buildBody(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("ReadMate"),
      actions: [
        buildSearchButton(),
        buildGoToBookshelfButton(),
        buildGoToProfileButton(context),
      ],
    );
  }

  IconButton buildSearchButton() {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () => _viewModel.goToSearchingView(context),
    );
  }

  IconButton buildGoToBookshelfButton() {
    return IconButton(
      icon: const Icon(Icons.collections_bookmark_sharp),
      onPressed: () {},
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

  Consumer<EbookProvider> buildBody() {
    return Consumer(
      builder: (context, provider, child) {
        return EbooksFrameWidget(
          ebooks: provider.ebooks,
          scrollController: _viewModel.scrollController,
          menuItems: const [
            MenuItems.details,
            MenuItems.add,
          ],
          onPressed: () {},
        );
      },
    );
  }
}
