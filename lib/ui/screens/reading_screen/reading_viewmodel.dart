import 'package:flutter/material.dart';
import 'package:readmate_app/models/bookmark.dart';
import 'package:readmate_app/models/ebook.dart';
import 'package:readmate_app/providers/bookshelf_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadingViewModel {
  late WebViewController _webViewController;
  late String _originalBodyData;

  late Ebook ebook;

  ReadingViewModel() {
    _originalBodyData = "";
  }

  void addToBookshelf() {
    bookshelfProvider.addEbook(Bookmark(
      ebookId: ebook.id,
      last: 0,
    ));
  }

  void goToHomeView(BuildContext context) {
    Navigator.pushNamed(context, "/home");

    _addBookmark();
  }

  void goToBookshelfView(BuildContext context) {
    Navigator.pushNamed(context, "/bookshelf");
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

  void _addBookmark() async {
    if (bookshelfProvider.ebooks.contains(ebook)) {
      Bookmark bookmark = Bookmark(
        ebookId: ebook.id,
        last: await _getLast(),
      );

      bookshelfProvider.updateEbookBookmark(bookmark);
    }
  }

  void goToLast() async {
    Bookmark? bookmark = await bookshelfProvider.getEbookBookmark(ebook.id);

    if (bookmark != null) {
      _webViewController.scrollTo(0, bookmark.last);
    }
  }

  Future<int> _getLast() async {
    return await _webViewController.getScrollY();
  }

  void onBarClosed() {
    _loadOriginalBodyData();
  }

  void initializeWebViewController(WebViewController controller) {
    _webViewController = controller;
  }

  void _loadOriginalBodyData() async {
    // load the original, first, html data to web view
    await _webViewController.runJavascript(
      'document.getElementsByTagName("body")[0].innerHTML = $_originalBodyData',
    );
  }

  void setOriginalBodyData() async {
    // gets body of current html page
    String getBodyCommand = 'document.getElementsByTagName("body")[0].innerHTML';

    _originalBodyData = await _webViewController.runJavascriptReturningResult(getBodyCommand);
  }
}
