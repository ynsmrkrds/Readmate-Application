class Author {
  final String name;
  final int? birthYear;
  final int? deathYear;

  Author({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json["name"] as String,
      birthYear: json["birth_year"] as int?,
      deathYear: json["death_year"] as int?,
    );
  }
}
