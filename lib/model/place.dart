import 'dart:convert';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
    Place({
      required  this.statusCode,
      required  this.message,
        this.data,
    });

    int statusCode;
    String message;
    DataPlace? data;

    factory Place.fromJson(Map<String, dynamic> json) => Place(
        statusCode: json["status_code"],
        message: json["message"],
        data: DataPlace.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data?.toJson(),
    };
}

class DataPlace {
    DataPlace({
        this.header,
        this.content,
    });

    Header? header;
    List<Content>? content;

    factory DataPlace.fromJson(Map<String, dynamic> json) => DataPlace(
        header: Header.fromJson(json["header"]),
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "header": header?.toJson(),
        "content": List<dynamic>.from(content!.map((x) => x.toJson())),
    };
}

class Content {
    Content({
        this.id,
        this.title,
        this.content,
        this.type,
        this.image,
        this.media,
    });

    int? id;
    String? title;
    String? content;
    String? type;
    String? image;
    List<String>? media;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        type: json["type"],
        image:  json["image"],
        media: List<String>.from(json["media"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "type": type,
        "image":  image,
        "media": List<dynamic>.from(media!.map((x) => x)),
    };
}

class Header {
    Header({
        this.title,
        this.subtitle,
    });

    String? title;
    String? subtitle;

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        title: json["title"],
        subtitle: json["subtitle"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
    };
}
