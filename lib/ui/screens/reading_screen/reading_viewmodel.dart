import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmate_app/core/models/bookmark.dart';
import 'package:readmate_app/core/models/ebook.dart';
import 'package:readmate_app/core/providers/account_provider.dart';
import 'package:readmate_app/core/providers/bookshelf_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadingViewModel {
  late WebViewController _webViewController;
  late String _originalBodyData;

  late Ebook ebook;

  late final ValueNotifier<bool> _isLoadNotifier;

  ReadingViewModel() {
    _originalBodyData = "";

    _isLoadNotifier = ValueNotifier<bool>(false);
  }

  ValueNotifier<bool> get isLoadNotifier => _isLoadNotifier;

  void initializeWebViewController(WebViewController controller) {
    _webViewController = controller;
  }

  void search(String keyword) async {
    if (keyword != "") {
      await _loadOriginalBodyData();

      String searchAndHighlightCommand = 'document.getElementsByTagName("body")[0].innerHTML';
      searchAndHighlightCommand += '=';
      searchAndHighlightCommand += '(document.getElementsByTagName("body")[0].innerHTML)';
      searchAndHighlightCommand += '.replace(new RegExp("$keyword", "gi"),';
      searchAndHighlightCommand += r'"<mark>$&</mark>");';

      await _webViewController.runJavascript(searchAndHighlightCommand);
    }
  }

  void setOriginalBodyData() async {
    if (accountProvider.user == null) {
      // 20% of the content of the e-book is shown to the guest user
      String limitCommand = "var body = document.getElementsByTagName('body')[0];";
      limitCommand += "var length = body.children.length;";
      limitCommand += "for (var i = length-1; i > (length * 0.2); i--) {body.children[i].remove()}";
      await _webViewController.runJavascriptReturningResult(limitCommand);

      // adds a warning message to the end of 20% of the content of the e-book
      String warningMessageCommand = r"const warning = document.createElement('div');";
      warningMessageCommand +=
          r"""warning.innerHTML = "<h2 style='padding:24px;background-color:#ffbd4d;color:Black;text-align:center;'>Authenticate to view the entire ebook!</h2>";""";
      warningMessageCommand += r"document.body.appendChild(warning);";
      await _webViewController.runJavascript(warningMessageCommand);
    }

    // gets body of current html page
    String getBodyCommand = 'document.getElementsByTagName("body")[0].innerHTML';
    _originalBodyData = await _webViewController.runJavascriptReturningResult(getBodyCommand);

    _isLoadNotifier.value = true;
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

  Future<void> _loadOriginalBodyData() async {
    // load the original, first, html data to web view
    await _webViewController.runJavascript(
      'document.getElementsByTagName("body")[0].innerHTML = $_originalBodyData',
    );
  }
}
