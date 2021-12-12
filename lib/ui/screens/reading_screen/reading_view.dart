import 'package:flutter/material.dart';
import 'package:readmate_app/core/models/ebook.dart';
import 'package:readmate_app/ui/screens/reading_screen/reading_viewmodel.dart';
import 'package:readmate_app/ui/widgets/searching_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadingView extends StatelessWidget {
  final ReadingViewModel _viewModel = ReadingViewModel();

  ReadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _viewModel.ebook = ModalRoute.of(context)!.settings.arguments as Ebook;

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
      leading: buildAppBarLeading(context),
      title: buildAppBarTitle(),
    );
  }

  IconButton buildAppBarLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.home),
      onPressed: () => _viewModel.goToHomeView(context),
    );
  }

  SearchingBarWidget buildAppBarTitle() {
    return SearchingBarWidget(
      title: Flexible(
        child: Text(
          _viewModel.ebook.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onSubmitted: (keyword) => _viewModel.search(keyword),
      onBarClosed: () => _viewModel.onSearchBarClosed(),
    );
  }

  WebView buildBody() {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: _viewModel.ebook.link,
      onWebViewCreated: (controller) => _viewModel.initializeWebViewController(controller),
      onPageStarted: (url) => _viewModel.goToLast(),
      onPageFinished: (url) => _viewModel.setOriginalBodyData(),
    );
  }
}
