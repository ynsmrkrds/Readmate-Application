import 'package:flutter/material.dart';
import 'package:readmate_app/core/models/ebook.dart';
import 'package:readmate_app/core/services/library_service.dart';

class EbookProvider extends ChangeNotifier {
  final List<Ebook> ebooks = [];

  Future<bool> fetchEbook(int ebookId) async {
    bool result = false;

    Ebook? ebook = await LibraryService.fetch(ebookId);

    if (ebook != null) {
      ebooks.add(ebook);
      notifyListeners();

      result = true;
    }

    return result;
  }
}

EbookProvider ebookProvider = EbookProvider();
