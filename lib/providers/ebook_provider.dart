import 'package:flutter/material.dart';
import 'package:readmate_app/models/ebook.dart';
import 'package:readmate_app/services/library_service.dart';

class EbookProvider extends ChangeNotifier {
  final List<Ebook> ebooks = [];

  void fetchEbooks(int id) async {
    Ebook? ebook = await LibraryService.fetch(id);

    if (ebook != null) {
      ebooks.add(ebook);

      notifyListeners();
    }
  }
}

EbookProvider ebookProvider = EbookProvider();
