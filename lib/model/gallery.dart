// To parse this JSON data, do
//
//     final Galery = GaleryFromJson(jsonString);

import 'dart:convert';

Galery galeryFromJson(String str) => Galery.fromJson(json.decode(str));

String galeryToJson(Galery data) => json.encode(data.toJson());

class Galery {
    Galery({
      required  this.statusCode,
      required  this.message,
        this.data,
    });

    int statusCode;
    String message;
    List<DataGallery>? data;

    factory Galery.fromJson(Map<String, dynamic> json) => Galery(
        statusCode: json["status_code"],
        message: json["message"],
        data: List<DataGallery>.from(json["data"].map((x) => DataGallery.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataGallery {
    DataGallery({
        this.caption,
        this.thumbnail,
        this.image,
    });

    String? caption;
    String? thumbnail;
    String? image;

    factory DataGallery.fromJson(Map<String, dynamic> json) => DataGallery(
        caption: json["caption"],
        thumbnail: json["thumbnail"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "caption": caption,
        "thumbnail": thumbnail,
        "image": image,
    };
}
