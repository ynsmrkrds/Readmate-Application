import 'package:flutter/cupertino.dart';
import 'package:readmate_app/models/ebook.dart';
import 'package:readmate_app/models/library.dart';
import 'package:readmate_app/services/library_service.dart';

class LibraryProvider extends ChangeNotifier {
  final List<Ebook> ebooks = [];

  late Library? library;

  void searchEbook(String keyword) async {
    if (keyword == "") {
      ebooks.clear();

      notifyListeners();
    } else {
      library = await LibraryService.search(keyword);

      if (library != null) {
        ebooks.clear();
        ebooks.addAll(library!.results);

        notifyListeners();
      }
    }
  }

  void loadMore() async {
    String? url = libraryProvider.library!.next;
    if (url != null) {
      library = await LibraryService.fetchNextPage(url);

      if (library != null) {
        ebooks.addAll(library!.results);

        notifyListeners();
      }
    }
  }
}

LibraryProvider libraryProvider = LibraryProvider();
