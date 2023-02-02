// ignore_for_file: file_names, prefer_typing_uninitialized_variables

class User {
  var id;
  String? email;
  String? password;

  User({this.id, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
