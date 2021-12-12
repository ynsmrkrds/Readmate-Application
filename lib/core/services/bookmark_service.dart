import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readmate_app/core/models/bookmark.dart';

class BookmarkService {
  static final FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;

  static final CollectionReference<Map<String, dynamic>> _bookshelves =
      _firebaseFirestoreInstance.collection("bookshelves");

  static Future<bool> addBookmark(String userId, Bookmark bookmark) async {
    bool result = false;

    await _bookshelves
        .doc(userId)
        .collection("bookmarks")
        .doc(bookmark.ebookId.toString())
        .set(bookmark.toJson())
        .then((value) => result = true)
        .catchError((error) => result = false);

    return result;
  }

  static Future<List<Bookmark>?> getBookmarks(String userId) async {
    List<Bookmark> bookmarks = [];

    try {
      await _bookshelves.doc(userId).collection("bookmarks").get().then((value) {
        for (var bookmark in value.docs) {
          bookmarks.add(Bookmark.fromJson(bookmark.data()));
        }
      });

      return bookmarks;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> removeBookmark(String userId, int ebookId) async {
    bool result = false;

    await _bookshelves
        .doc(userId)
        .collection("bookmarks")
        .doc(ebookId.toString())
        .delete()
        .then((value) => result = true)
        .catchError((error) => result = false);

    return result;
  }

  static Future<bool> updateBookmark(String userId, Bookmark bookmark) async {
    bool result = false;

    await _bookshelves
        .doc(userId)
        .collection("bookmarks")
        .doc(bookmark.ebookId.toString())
        .set(bookmark.toJson())
        .then((value) => result = true)
        .catchError((error) => result = false);

    return result;
  }
}
