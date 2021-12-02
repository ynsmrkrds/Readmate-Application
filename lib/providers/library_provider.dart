import 'package:flutter/material.dart';
import 'package:readmate_app/models/ebook.dart';
import 'package:readmate_app/services/library_service.dart';

class LibraryProvider extends ChangeNotifier {
  final List<Ebook> ebooks = [];

  void fetchEbooks(int id) async {
    Ebook? ebook = await LibraryService.fetch(id);

    if (ebook != null) {
      ebooks.add(ebook);

      notifyListeners();
    }
  }
}

LibraryProvider libraryProvider = LibraryProvider();
