import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:readmate_app/core/providers/library_provider.dart';
import 'package:readmate_app/ui/screens/searching_screen/searching_viewmodel.dart';
import 'package:readmate_app/ui/widgets/ebooks_frame_widget.dart';
import 'package:readmate_app/ui/widgets/searching_text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  void dispose() {
    super.dispose();

    _viewModel.clearMemory();
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
      title: buildAppBarTitle(),
    );
  }

  SearchingTextFieldWidget buildAppBarTitle() {
    return SearchingTextFieldWidget(
      onSubmitted: (value) => _viewModel.searchEbook(value),
    );
  }

  Consumer<LibraryProvider> buildBody() {
    return Consumer(
      builder: (context, provider, child) {
        return provider.ebooks.isEmpty ? buildNoResultImage() : buildEbooksFrame(provider);
      },
    );
  }

  Padding buildNoResultImage() {
    return Padding(
      padding: EdgeInsets.all(48.0.w),
      child: SvgPicture.asset("assets/no_result.svg"),
    );
  }

  EbooksFrameWidget buildEbooksFrame(LibraryProvider provider) {
    return EbooksFrameWidget(
      ebooks: provider.ebooks,
      scrollController: _viewModel.scrollController,
      menuItems: [
        MenuItems.details,
        if (_viewModel.isGuest() == false) MenuItems.add,
      ],
    );
  }
}
