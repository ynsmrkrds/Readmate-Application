import 'package:readmate_app/providers/bookshelf_provider.dart';

class BookshelfViewModel {
  void fetchBookshelf() {
    bookshelfProvider.getBookshelf();
  }

  void searchEbook(String title) {
    bookshelfProvider.searchEbook(title);
  }
}
