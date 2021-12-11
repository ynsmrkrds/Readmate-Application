import 'package:flutter/material.dart';
import 'package:readmate_app/models/ebook.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SearchingBarWidget(
          title: Flexible(
            child: Text(
              _viewModel.ebook.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          onSubmitted: (keyword) {
            _viewModel.search(keyword);
          },
          onBarClosed: () => _viewModel.onBarClosed(),
        ),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => _viewModel.goToHomeView(context),
        ),
      ),
      body: Center(
        child: buildBody(),
      ),
    );
  }

  WebView buildBody() {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: _viewModel.ebook.link,
      onWebViewCreated: (controller) {
        _viewModel.initializeWebViewController(controller);
      },
      onPageStarted: (url) {
        _viewModel.goToLast();
      },
      onPageFinished: (url) {
        _viewModel.setOriginalBodyData();
      },
    );
  }
}
