import 'dart:math';

import 'package:flutter/material.dart';
import 'package:readmate_app/models/ebook.dart';
import 'package:readmate_app/providers/library_provider.dart';

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

  List<Ebook> get ebooks => libraryProvider.ebooks;

  ScrollController get scrollController => _scrollController;

  void fetchEbooks() async {
    for (int id in _generateRandomNumber()) {
      libraryProvider.fetchEbooks(id);
    }
  }

  List<int> _generateRandomNumber() {
    Random random = Random();
    return List.generate(25, (index) => random.nextInt(15933));
  }

  void goToProfileView(BuildContext context) {
    Navigator.pushNamed(context, "/profile");
  }

  void goToDetailsView(BuildContext context, int index) {
    Navigator.pushNamed(
      context,
      "/details",
      arguments: index,
    );
  }
}
