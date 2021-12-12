import 'package:flutter/material.dart';
import 'package:readmate_app/core/models/bookmark.dart';
import 'package:readmate_app/core/models/ebook.dart';
import 'package:readmate_app/core/services/bookmark_service.dart';
import 'package:readmate_app/core/services/library_service.dart';

class BookshelfProvider extends ChangeNotifier {
  List<Ebook> ebooks = []; // list of ebooks in the user's bookshelf
  List<Bookmark> _bookmarks = []; // list of bookmarks of ebooks in the user's bookshelf

  // adds an ebook to bookshelf of user
  Future<bool> addEbook(String userId, Ebook ebook) async {
    bool result = false;

    // checks if ebook exists in ebooks list
    bool isThere = ebooks.contains(ebook);

    // adding process doesn't occur if ebook exists
    // otherwise adds to bookshelf the ebook
    if (isThere == false) {
      // creates a bookmark for ebook
      Bookmark bookmark = Bookmark(ebookId: ebook.id, last: 0);

      // starts the process of adding the ebook to the server
      result = await BookmarkService.addBookmark(userId, bookmark);

      // updates the ebooks and bookmarks list if everything OK
      if (result == true) {
        ebooks.add(ebook);
        notifyListeners();

        _bookmarks.add(bookmark);
      }
    }

    return result;
  }

  // removes an ebook from bookshelf of user
  Future<bool> removeEbook(String userId, int ebookId) async {
    bool result = false;

    // checks if ebook exists in ebooks list
    bool isThere = ebooks.any((ebook) => ebook.id == ebookId);

    // removing process occur if ebook exists
    if (isThere == true) {
      // starts the process of removing the ebook from the server
      result = await BookmarkService.removeBookmark(userId, ebookId);

      // updates the ebooks and bookmarks list if everything OK
      if (result == true) {
        ebooks.removeWhere((ebook) => ebook.id == ebookId);
        notifyListeners();

        _bookmarks.removeWhere((bookmark) => bookmark.ebookId == ebookId);
      }
    }

    return result;
  }

  // searches an ebook in the ebooks list
  void searchEbook(String userId, String title) async {
    await getBookshelf(userId);

    ebooks.replaceRange(
      0,
      ebooks.length,
      ebooks.where((element) => element.title.toLowerCase().contains(title.toLowerCase())),
    );
    notifyListeners();
  }

  // updates bookmark of ebook in the ebooks list
  Future<bool> updateBookmark(String userId, Ebook ebook, int last) async {
    bool result = false;

    // checks if ebook exists in ebooks list
    bool isThere = ebooks.contains(ebook);

    // updating process occur if ebook exists
    if (isThere == true) {
      // creates a bookmark for ebook
      Bookmark bookmark = Bookmark(ebookId: ebook.id, last: last);

      // starts the process of updating the ebook that in the server
      result = await BookmarkService.updateBookmark(userId, bookmark);

      // updates the bookmark of ebook in the ebooks list
      _bookmarks[_bookmarks.indexOf(bookmark)] = bookmark;
    }

    return result;
  }

  // returns the bookmark of ebook with ebookId
  Bookmark getBookmark(int ebookId) {
    return _bookmarks.firstWhere((bookmark) => bookmark.ebookId == ebookId);
  }

  // gets all ebooks in the bookshelf of the user with userId
  Future<bool> getBookshelf(String userId) async {
    List<Bookmark>? result = await BookmarkService.getBookmarks(userId);

    if (result != null) {
      _bookmarks.clear();
      _bookmarks.addAll(result);

      return await _getEbooksInBookshelf();
    } else {
      return false;
    }
  }

  // gets bookmarked ebooks from server
  Future<bool> _getEbooksInBookshelf() async {
    bool result = false;

    for (Bookmark bookmark in _bookmarks) {
      // checks if ebook exists in ebooks list
      bool isThere = ebooks.any((ebook) => bookmark.ebookId == ebook.id);

      // adding process doesn't occur if ebook exists
      // otherwise adds to bookshelf the ebook
      if (isThere == false) {
        Ebook? ebook = await LibraryService.fetch(bookmark.ebookId);

        if (ebook != null) {
          ebooks.add(ebook);
          notifyListeners();

          result = true;
        } else {
          result = false;
          break;
        }
      }
    }

    return result;
  }
}

BookshelfProvider bookshelfProvider = BookshelfProvider();
