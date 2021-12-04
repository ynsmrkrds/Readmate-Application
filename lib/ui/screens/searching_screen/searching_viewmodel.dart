import 'package:flutter/material.dart';
import 'package:readmate_app/providers/library_provider.dart';

class SearchingViewModel {
  late final ScrollController _scrollController;

  SearchingViewModel() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  ScrollController get scrollController => _scrollController;

  void searchEbook(String keyword) {
    libraryProvider.searchEbook(keyword);
  }

  void loadMore() {
    libraryProvider.loadMore();
  }

  void clearMemory() {
    libraryProvider.ebooks.clear();
  }
}
