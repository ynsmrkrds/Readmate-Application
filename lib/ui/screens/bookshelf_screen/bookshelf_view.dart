import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:readmate_app/core/providers/bookshelf_provider.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: buildBody(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: SearchingBarWidget(
        title: const Text("Bookshelf"),
        onSubmitted: (value) => _viewModel.searchEbook(value),
        onBarClosed: () => _viewModel.fetchBookshelf(),
      ),
    );
  }

  Consumer<BookshelfProvider> buildBody() {
    return Consumer(
      builder: (context, provider, child) {
        return provider.ebooks.isEmpty ? buildNoResultImage() : buildEbooksFrame(provider);
      },
    );
  }

  Padding buildNoResultImage() {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: SvgPicture.asset(
        "assets/no_result.svg",
      ),
    );
  }

  EbooksFrameWidget buildEbooksFrame(BookshelfProvider provider) {
    return EbooksFrameWidget(
      ebooks: provider.ebooks,
      menuItems: const [
        MenuItems.details,
        MenuItems.remove,
      ],
    );
  }
}
