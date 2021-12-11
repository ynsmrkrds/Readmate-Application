import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readmate_app/models/bookmark.dart';
import 'package:readmate_app/services/authentication_service.dart';

class BookmarkService {
  static final User? _user = AuthenticationService.getUser();

  static final CollectionReference<Map<String, dynamic>> _bookshelves =
      FirebaseFirestore.instance.collection("bookshelves").doc(_user!.uid).collection("bookmarks");

  static Future<bool> addBookmark(Bookmark bookmark) async {
    bool result = false;

    _bookshelves
        .doc(bookmark.ebookId.toString())
        .set(bookmark.toJson())
        .then((value) => result = true)
        .catchError((error) => result = false);

    return result;
  }

  static Future<List<Bookmark>?> getBookmarks() async {
    List<Bookmark> bookmarks = [];

    try {
      await _bookshelves.get().then((value) {
        for (var bookmark in value.docs) {
          bookmarks.add(Bookmark.fromJson(bookmark.data()));
        }
      });

      return bookmarks;
    } catch (e) {
      return null;
    }
  }

  static Future<Bookmark?> getBookmark(int ebookId) async {
    try {
      Bookmark? bookmark;

      await _bookshelves.doc(ebookId.toString()).get().then((value) {
        bookmark = Bookmark.fromJson(value.data()!);
      });

      return bookmark;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> removeTheBookmark(int ebookId) async {
    bool result = false;

    await _bookshelves
        .doc(ebookId.toString())
        .delete()
        .then((value) => result = true)
        .catchError((error) => result = false);

    return result;
  }

  static Future<bool> updateBookmark(Bookmark bookmark) async {
    _bookshelves.doc(bookmark.ebookId.toString()).set(bookmark.toJson());

    bool result = false;

    await _bookshelves
        .doc(bookmark.ebookId.toString())
        .set(bookmark.toJson())
        .then((value) => result = true)
        .catchError((error) => result = false);

    return result;
  }
}
