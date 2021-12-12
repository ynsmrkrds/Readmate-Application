import 'package:flutter/material.dart';
import 'package:readmate_app/core/models/bookmark.dart';
import 'package:readmate_app/core/models/ebook.dart';
import 'package:readmate_app/core/providers/account_provider.dart';
import 'package:readmate_app/core/providers/bookshelf_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadingViewModel {
  late WebViewController _webViewController;
  late String _originalBodyData;

  late Ebook ebook;

  ReadingViewModel() {
    _originalBodyData = "";
  }

  void initializeWebViewController(WebViewController controller) {
    _webViewController = controller;
  }

  void search(String keyword) async {
    if (keyword != "") {
      _loadOriginalBodyData();

      String searchAndHighlightCommand = 'document.getElementsByTagName("body")[0].innerHTML';
      searchAndHighlightCommand += '=';
      searchAndHighlightCommand += '(document.getElementsByTagName("body")[0].innerHTML)';
      searchAndHighlightCommand += '.replace(new RegExp("$keyword", "gi"),';
      searchAndHighlightCommand += r'"<mark>$&</mark>");';

      await _webViewController.runJavascript(searchAndHighlightCommand);
    }
  }

  void setOriginalBodyData() async {
    // gets body of current html page
    String getBodyCommand = 'document.getElementsByTagName("body")[0].innerHTML';

    _originalBodyData = await _webViewController.runJavascriptReturningResult(getBodyCommand);
  }

  void goToLast() async {
    Bookmark bookmark = await bookshelfProvider.getBookmark(ebook.id);

    _webViewController.scrollTo(0, bookmark.last);
  }

  void onSearchBarClosed() {
    _loadOriginalBodyData();
  }

  void goToHomeView(BuildContext context) {
    Navigator.pushNamed(context, "/home");

    _addBookmark();
  }

  Future<int> _getLast() async {
    return await _webViewController.getScrollY();
  }

  void _addBookmark() async {
    if (bookshelfProvider.ebooks.contains(ebook)) {
      bookshelfProvider.updateBookmark(accountProvider.user!.uid, ebook, await _getLast());
    }
  }

  void _loadOriginalBodyData() async {
    // load the original, first, html data to web view
    await _webViewController.runJavascript(
      'document.getElementsByTagName("body")[0].innerHTML = $_originalBodyData',
    );
  }
}
