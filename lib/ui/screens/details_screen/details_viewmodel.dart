import 'package:readmate_app/models/ebook.dart';
import 'package:readmate_app/providers/library_provider.dart';

class DetailsViewModel {
  late int _index;

  set index(int index) => _index = index;

  Ebook get ebook => libraryProvider.ebooks[_index];
}
