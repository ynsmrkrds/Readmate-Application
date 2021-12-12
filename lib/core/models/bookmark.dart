/* this class represents bookmark of ebook that 
  owned by the user */

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

  @override
  bool operator ==(other) {
    return (other is Bookmark) && other.ebookId == ebookId;
  }

  @override
  int get hashCode => ebookId.hashCode;
}
