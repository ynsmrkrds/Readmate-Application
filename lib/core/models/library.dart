/* this class represents a library that 
  includes all ebooks in the server */

import 'package:readmate_app/core/models/ebook.dart';

class Library {
  final int count;
  final String? next;
  final String? previous;
  final List<Ebook> results;

  Library({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      count: json["count"] as int,
      next: json["next"] as String?,
      previous: json["previous"] as String?,
      results: List<Ebook>.from(
        json["results"].toList().map((data) => Ebook.fromJson(data)).toList(),
      ),
    );
  }
}
