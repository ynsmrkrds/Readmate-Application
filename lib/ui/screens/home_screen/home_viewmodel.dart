import 'dart:math';

import 'package:flutter/material.dart';
import 'package:readmate_app/core/providers/account_provider.dart';
import 'package:readmate_app/core/providers/bookshelf_provider.dart';
import 'package:readmate_app/core/providers/ebook_provider.dart';

class HomeViewModel {
  late final ScrollController _scrollController;

  HomeViewModel() {
    _scrollController = ScrollController();

    _listenScrollController();
  }

  ScrollController get scrollController => _scrollController;

  bool isGuest() => accountProvider.user == null;

  void fetchEbooks() async {
    for (int id in _generateRandomNumber()) {
      ebookProvider.fetchEbook(id);
    }
  }

  void fetchBookshelf() {
    if (accountProvider.user != null) {
      bookshelfProvider.getBookshelf(accountProvider.user!.uid);
    }
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

  List<int> _generateRandomNumber() {
    Random random = Random();
    return List.generate(25, (index) => random.nextInt(15933));
  }

  void _listenScrollController() {
    _scrollController.addListener(() {
      // fetches more ebooks if user reached the bottom of grid view
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchEbooks();
      }
    });
  }
}
