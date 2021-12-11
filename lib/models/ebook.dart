import 'package:readmate_app/models/author.dart';

class Ebook {
  final int id;
  final String title;
  final List<String> subjects;
  final List<Author> authors;
  final List<String> languages;
  final String? link;
  final String? coverLink;

  Ebook({
    required this.id,
    required this.title,
    required this.subjects,
    required this.authors,
    required this.languages,
    required this.link,
    required this.coverLink,
  });

  factory Ebook.fromJson(Map<String, dynamic> json) {
    return Ebook(
      id: json["id"] as int,
      title: json["title"] as String,
      subjects: List<String>.from(
        json["subjects"].toList().map((i) => i).toList(),
      ),
      authors: List<Author>.from(
        json["authors"].toList().map((i) => Author.fromJson(i)).toList(),
      ),
      languages: List<String>.from(
        json["languages"].toList().map((i) => i).toList(),
      ),
      link: json["formats"]["text/html"] as String?,
      coverLink: json["formats"]["image/jpeg"] as String?,
    );
  }

  @override
  bool operator ==(other) {
    return (other is Ebook) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
