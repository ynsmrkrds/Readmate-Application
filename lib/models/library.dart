import 'package:readmate_app/models/ebook.dart';

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

  Library.empty([
    this.count = 0,
    // ignore: avoid_init_to_null
    this.next = null,
    // ignore: avoid_init_to_null
    this.previous = null,
    this.results = const [],
  ]);

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      count: json["count"] as int,
      next: json["next"] as String?,
      previous: json["previous"] as String?,
      results: List<Ebook>.from(
        json["results"].toList().map((i) => Ebook.fromJson(i)).toList(),
      ),
    );
  }
}
