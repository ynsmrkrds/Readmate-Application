import 'package:readmate_app/core/providers/account_provider.dart';
import 'package:readmate_app/core/providers/bookshelf_provider.dart';

class BookshelfViewModel {
  void fetchBookshelf() {
    bookshelfProvider.getBookshelf(accountProvider.user!.uid);
  }

  void searchEbook(String title) {
    bookshelfProvider.searchEbook(accountProvider.user!.uid, title);
  }
}
