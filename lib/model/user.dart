// To parse this JSON data, do
//
//     final User = UserFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
       required this.statusCode,
    required    this.message,
      this.data,
    });

    int statusCode;
    String message;
    DataUser? data;

    factory User.fromJson(Map<String, dynamic> json) => User(
        statusCode: json["status_code"],
        message: json["message"],
        data: DataUser.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data?.toJson(),
    };
}

class DataUser {
    DataUser({
        this.id,
        this.username,
        this.fullname,
        this.email,
        this.phone,
        this.avatar,
    });

    int? id;
    String? username;
    String? fullname;
    String? email;
    String? phone;
    String? avatar;

    factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        id: json["id"],
        username: json["username"],
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "avatar": avatar,
    };
}
