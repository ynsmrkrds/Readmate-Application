import 'package:flutter/material.dart';
import 'package:readmate_app/models/bookmark.dart';
import 'package:readmate_app/models/ebook.dart';
import 'package:readmate_app/services/bookmark_service.dart';
import 'package:readmate_app/services/library_service.dart';

class BookshelfProvider extends ChangeNotifier {
  List<Ebook> ebooks = [];

  void addEbook(Bookmark bookmark) {
    bool isThere = ebooks.any((ebook) => ebook.id == bookmark.ebookId);

    if (isThere == false) {
      BookmarkService.addBookmark(bookmark);
    }
  }

  void removeEbook(int ebookId) {
    BookmarkService.removeTheBookmark(ebookId);

    ebooks.removeWhere((ebook) => ebook.id == ebookId);
    notifyListeners();
  }

  void updateEbookBookmark(Bookmark bookmark) async {
    BookmarkService.updateBookmark(bookmark);
  }

  Future<Bookmark?> getEbookBookmark(int ebookId) async {
    return BookmarkService.getBookmark(ebookId);
  }

  void searchEbook(String title) async {
    await getBookshelf();

    ebooks.replaceRange(
      0,
      ebooks.length,
      ebooks.where((element) => element.title.toLowerCase().contains(title.toLowerCase())),
    );

    notifyListeners();
  }

  Future<void> getBookshelf() async {
    List<Bookmark>? bookmarks = await BookmarkService.getBookmarks();

    if (bookmarks != null) {
      for (Bookmark bookmark in bookmarks) {
        bool isThere = ebooks.any((ebook) => bookmark.ebookId == ebook.id);

        if (isThere == false) {
          Ebook? ebook = await LibraryService.fetch(bookmark.ebookId);

          if (ebook != null) {
            ebooks.add(ebook);

            notifyListeners();
          }
        }
      }
    }
  }
}

BookshelfProvider bookshelfProvider = BookshelfProvider();
