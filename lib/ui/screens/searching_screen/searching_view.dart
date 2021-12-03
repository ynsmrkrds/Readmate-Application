import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:readmate_app/enums/menu_items.dart';
import 'package:readmate_app/providers/library_provider.dart';
import 'package:readmate_app/ui/screens/searching_screen/searching_viewmodel.dart';
import 'package:readmate_app/ui/widgets/ebooks_frame_widget.dart';

class SearchingView extends StatefulWidget {
  const SearchingView({Key? key}) : super(key: key);

  @override
  State<SearchingView> createState() => _SearchingViewState();
}

class _SearchingViewState extends State<SearchingView> {
  late final SearchingViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = SearchingViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildSearchingTextField(),
      ),
      body: Center(
        child: buildBody(),
      ),
    );
  }

  TextField buildSearchingTextField() {
    return TextField(
      decoration: const InputDecoration(
        hintText: "Enter a keyword or a tag",
        hintStyle: TextStyle(color: Colors.black54),
        border: InputBorder.none,
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: (keyword) {
        _viewModel.searchEbook(keyword);
      },
    );
  }

  Consumer<LibraryProvider> buildBody() {
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
