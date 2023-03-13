class viewmood {
  String? feel;
  String? happen;
  String? date;
  String? id;

  viewmood();

  Map<String, dynamic> toJson() => {
        'feel': feel,
        'happen': happen,
        'date': date,
        'id': id,
      };
  viewmood.fromSnapshot(snapshot)
      : feel = snapshot.data()['feel'],
        happen = snapshot.data()['happen'],
        date = snapshot.data()['date'],
        id = snapshot.data()['id'];
}
