class viewfeed {
  String? content;
  String? date;
  String? id;

  viewfeed();

  Map<String, dynamic> toJson() => {
        'content': content,
        'date': date,
        'id': id,
      };
  viewfeed.fromSnapshot(snapshot)
      : content = snapshot.data()['content'],
        date = snapshot.data()['date'],
        id = snapshot.data()['id'];
}
