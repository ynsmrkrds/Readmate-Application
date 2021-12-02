import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:provider/provider.dart';
import 'package:readmate_app/models/ebook.dart';
import 'package:readmate_app/providers/library_provider.dart';
import 'package:readmate_app/ui/screens/home_screen/home_viewmodel.dart';
import 'package:readmate_app/ui/widgets/cover_image_widget.dart';

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
      onPressed: () {},
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

  Consumer<LibraryProvider> buildBody() {
    return Consumer(
      builder: (context, provider, child) => buildEbooksFrame(provider),
    );
  }

  GridView buildEbooksFrame(LibraryProvider provider) {
    return GridView.builder(
      controller: _viewModel.scrollController,
      padding: const EdgeInsets.all(18.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: provider.ebooks.length,
      itemBuilder: (context, index) {
        final ebook = provider.ebooks[index];

        return FocusedMenuHolder(
          blurSize: 4,
          blurBackgroundColor: Colors.black,
          menuWidth: MediaQuery.of(context).size.width * 0.5,
          menuItems: [
            buildGoToDetailsButton(index),
            buildAddToBookshelfButton(),
          ],
          onPressed: () {},
          child: buildEbookFrame(ebook),
        );
      },
    );
  }

  FocusedMenuItem buildGoToDetailsButton(int index) {
    return FocusedMenuItem(
      title: const Text("Details"),
      trailingIcon: const Icon(Icons.info),
      onPressed: () => _viewModel.goToDetailsView(context, index),
    );
  }

  FocusedMenuItem buildAddToBookshelfButton() {
    return FocusedMenuItem(
      title: const Text("Add to Bookshelf"),
      trailingIcon: const Icon(Icons.add_to_photos),
      onPressed: () {},
    );
  }

  Card buildEbookFrame(Ebook ebook) {
    return Card(
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: CoverImageWidget(url: ebook.coverLink),
            ),
            Flexible(
              child: buildEbookTitleText(ebook),
            ),
          ],
        ),
      ),
    );
  }

  Text buildEbookTitleText(Ebook ebook) => Text(ebook.title);
}
