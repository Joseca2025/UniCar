import 'dart:convert';

class User {
  User({
    // this.id,
    required this.email,
    required this.name,
    required this.lastname,
    required this.telefono,
    required this.registro,
    required this.tipouser,
             this.photoUrl,
  });

  //int? id;

  String email;
  String name;
  String lastname;
  String telefono;
  int registro;
  String tipouser;
  String? photoUrl;
  String? id;


  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        // id: json["id"],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        telefono: json["telefono"],
        registro: json["registro"],
        tipouser: json["tipouser"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toMap() => {
        //"id": id,
        "name": name,
        "email": email,
        "lastname": lastname,
        "registro": registro,
        "telefono": telefono,
        "tipouser": tipouser,
        "photoUrl": photoUrl
      };

  // bool get isEmpty => id == 0 && name.isEmpty && email.isEmpty;

  /* static List<User> parseUsers(String jsonString) {
    final Map<String, dynamic> parsedJson = json.decode(jsonString);
    final List<dynamic>? userListJson = parsedJson['users'];
    if (userListJson != null) {
      return userListJson.map((user) => User.fromMap(user)).toList();
    } else {
      return [];
    }
  } */


}