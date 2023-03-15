class feed {
  String? content;
  String? date;
  String? id;

  feed({this.date, this.content, this.id});

  factory feed.fromMap(map) {
    return feed(
      content: map['content'],
      date: map['date'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'happen': content,
      'date': date,
      'id': id,
    };
  }
}
