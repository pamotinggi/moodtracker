class mood {
  String? feel;
  String? happen;
  String? date;
  String? id;

  mood({this.date, this.feel, this.happen, this.id});

  factory mood.fromMap(map) {
    return mood(
      feel: map['feel'],
      happen: map['happen'],
      date: map['date'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'feel': feel,
      'happen': happen,
      'date': date,
      'id': id,
    };
  }
}
