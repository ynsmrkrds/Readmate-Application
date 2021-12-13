import 'package:flutter/material.dart';
import 'package:readmate_app/core/providers/account_provider.dart';
import 'package:readmate_app/core/providers/library_provider.dart';

class SearchingViewModel {
  late final ScrollController _scrollController;

  SearchingViewModel() {
    _scrollController = ScrollController();

    _listenScrollController();
  }

  ScrollController get scrollController => _scrollController;

  bool isGuest() => accountProvider.user == null;

  void searchEbook(String keyword) {
    libraryProvider.searchEbook(keyword);
  }

  void loadMore() {
    libraryProvider.loadMore();
  }

  void clearMemory() {
    libraryProvider.ebooks.clear();
  }

  void _listenScrollController() {
    _scrollController.addListener(() {
      // fetches more ebooks if user reached the bottom of grid view
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }
}
