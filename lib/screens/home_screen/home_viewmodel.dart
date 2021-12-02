import 'dart:math';

import 'package:flutter/material.dart';
import 'package:readmate_app/models/ebook.dart';
import 'package:readmate_app/services/library_service.dart';

class HomeViewModel with ChangeNotifier {
  late final List<Ebook> _ebooks;
  late final ScrollController _scrollController;

  HomeViewModel() {
    _ebooks = [];
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchEbooks();
      }
    });
  }

  List<Ebook> get ebooks => _ebooks;

  ScrollController get scrollController => _scrollController;

  void fetchEbooks() async {
    for (int id in _generateRandomNumber()) {
      Ebook? ebook = await LibraryService.fetch(id);

      if (ebook != null) {
        _ebooks.add(ebook);

        notifyListeners();
      }
    }
  }

  List<int> _generateRandomNumber() {
    Random random = Random();
    return List.generate(25, (index) => random.nextInt(15933));
  }

  void goToProfileView(BuildContext context) {
    Navigator.pushNamed(context, "/profile");
  }
}
