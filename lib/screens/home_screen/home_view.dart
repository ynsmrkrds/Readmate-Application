import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:provider/provider.dart';
import 'package:readmate_app/screens/home_screen/home_viewmodel.dart';

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

    _viewModel = Provider.of<HomeViewModel>(context, listen: false);

    _viewModel.fetchEbooks();
  }

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

  Consumer<HomeViewModel> buildBody() {
    return Consumer(builder: (context, provider, child) {
      // print("asd");

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
            onPressed: () {},
            menuItems: [
              FocusedMenuItem(
                title: const Text("Details"),
                trailingIcon: const Icon(Icons.info),
                onPressed: () {},
              ),
              FocusedMenuItem(
                title: const Text("Add to Bookshelf"),
                trailingIcon: const Icon(Icons.add_to_photos),
                onPressed: () {},
              ),
            ],
            child: Card(
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Image.network(
                        ebook.coverLink ?? "",
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                    Flexible(
                      child: Text(
                        ebook.title,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
