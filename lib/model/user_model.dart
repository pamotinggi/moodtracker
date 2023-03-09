class UserModel {
  String? uid;
  String? email;
  String? name;
  String? username;

  UserModel({this.uid, this.email, this.name, this.username});

  //retieve data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      username: map['username'],
    );
  }
  // send data to the server
  Map<String, dynamic> toMap() {
    return{
      'uid': uid,
      'email': email,
      'firstName': name,
      'username': username,
    };
  }
}
