import 'dart:math';

import 'package:flutter/material.dart';
import 'package:readmate_app/providers/bookshelf_provider.dart';
import 'package:readmate_app/providers/ebook_provider.dart';

class HomeViewModel {
  late final ScrollController _scrollController;

  HomeViewModel() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchEbooks();
      }
    });
  }

  ScrollController get scrollController => _scrollController;

  void fetchEbooks() async {
    for (int id in _generateRandomNumber()) {
      ebookProvider.fetchEbooks(id);
    }
  }

  void fetchBookshelf() {
    bookshelfProvider.getBookshelf();
  }

  List<int> _generateRandomNumber() {
    Random random = Random();
    return List.generate(25, (index) => random.nextInt(15933));
  }

  void goToSearchingView(BuildContext context) {
    Navigator.pushNamed(context, "/searching");
  }

  void goToBookshelfView(BuildContext context) {
    Navigator.pushNamed(context, "/bookshelf");
  }

  void goToProfileView(BuildContext context) {
    Navigator.pushNamed(context, "/profile");
  }
}
