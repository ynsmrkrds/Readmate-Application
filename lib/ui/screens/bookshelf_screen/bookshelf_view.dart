import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:readmate_app/enums/menu_items.dart';
import 'package:readmate_app/providers/bookshelf_provider.dart';
import 'package:readmate_app/ui/screens/bookshelf_screen/bookshelf_viewmodel.dart';
import 'package:readmate_app/ui/widgets/searching_bar_widget.dart';
import 'package:readmate_app/ui/widgets/ebooks_frame_widget.dart';

class BookshelfView extends StatefulWidget {
  const BookshelfView({Key? key}) : super(key: key);

  @override
  State<BookshelfView> createState() => _BookshelfViewState();
}

class _BookshelfViewState extends State<BookshelfView> {
  late final BookshelfViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = BookshelfViewModel();

    _viewModel.fetchBookshelf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchingBarWidget(
          title: const Text("Bookshelf"),
          onSubmitted: (value) {
            _viewModel.searchEbook(value);
          },
          onBarClosed: () {
            _viewModel.fetchBookshelf();
          },
        ),
      ),
      body: Center(
        child: buildBody(),
      ),
    );
  }

  Consumer<BookshelfProvider> buildBody() {
    return Consumer(
      builder: (context, provider, child) {
        return provider.ebooks.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(48.0),
                child: SvgPicture.asset(
                  "assets/no_result.svg",
                ),
              )
            : EbooksFrameWidget(
                ebooks: provider.ebooks,
                menuItems: const [
                  MenuItems.details,
                  MenuItems.remove,
                ],
              );
      },
    );
  }
}
