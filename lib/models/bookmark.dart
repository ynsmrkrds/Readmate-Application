class Bookmark {
  final int ebookId;
  final int last;

  Bookmark({
    required this.ebookId,
    required this.last,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      ebookId: json["ebookId"] as int,
      last: json["last"] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ebookId": ebookId,
      "last": last,
    };
  }
}
