import 'package:flutter/cupertino.dart';
import 'package:readmate_app/core/models/ebook.dart';
import 'package:readmate_app/core/models/library.dart';
import 'package:readmate_app/core/services/library_service.dart';

class LibraryProvider extends ChangeNotifier {
  final List<Ebook> ebooks = [];

  late Library? _library;

  Future<bool> searchEbook(String keyword) async {
    bool result = false;

    ebooks.clear();
    notifyListeners();

    if (keyword != "") {
      _library = await LibraryService.search(keyword);

      if (_library != null) {
        ebooks.clear();
        ebooks.addAll(_library!.results);

        notifyListeners();
      }
    }

    return result;
  }

  void loadMore() async {
    String? url = _library!.next;

    if (url != null) {
      _library = await LibraryService.fetchNextPage(url);

      if (_library != null) {
        ebooks.addAll(_library!.results);
        notifyListeners();
      }
    }
  }
}

LibraryProvider libraryProvider = LibraryProvider();
